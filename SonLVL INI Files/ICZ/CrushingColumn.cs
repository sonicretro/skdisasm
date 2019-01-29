using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.ICZ
{
	class CrushingColumn : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[][] sprites;

		private Sprite overlay;

		public override string Name
		{
			get { return "Crushing Column"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override byte DefaultSubtype
		{
			get { return 0x03; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype - 1];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0 || obj.SubType > 4) return null;

			var targetY = obj.SubType > 2 ? FindFloor(obj) : FindCeiling(obj);
			if (targetY == 0) return null;

			return new Sprite(overlay, 0, targetY - obj.Y);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprites[obj.SubType == 0 || obj.SubType > 5 ? 2 : 0][0].Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/ICZ/Misc Object Data/Map - Wall and Column.asm", version);

			subtypeNames = new[]
			{
				"Ceiling Crush",
				"Ceiling Crush (periodic)",
				"Floor Crush",
				"Floor Crush (periodic)",
				"Stationary (Knux only)"
			};

			var subtypes = new byte[subtypeNames.Length];
			for (var index = 0; index < subtypes.Length; index++)
				subtypes[index] = (byte)(index + 1);

			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
			sprites = new Sprite[3][];

			sprites[0] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 2, 2));
			sprites[1] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 12, 2));

			var extra = ObjectHelper.MapToBmp(art, map, 13, 2);
			extra.Offset(0, 0xB0);

			for (var index = 0; index < 4; index++)
				sprites[1][index] = new Sprite(extra, sprites[1][index]);

			sprites[2] = BuildFlippedSprites(ObjectHelper.UnknownObject);

			var bitmap = new BitmapBits(sprites[0][0].Size);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bitmap.Width - 1, bitmap.Height - 1);
			overlay = new Sprite(bitmap, sprites[0][0].X, sprites[0][0].Y);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[subtype != 0 && subtype < 6 ? subtype > 2 ? 0 : 1 : 2];
		}

		private int FindFloor(ObjectEntry obj)
		{
			var objY = obj.Y + overlay.Bottom + 1;
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = obj.X / LevelData.Level.ChunkWidth;
			var blockX = obj.X % LevelData.Level.ChunkWidth / 16;
			var solidX = obj.X % 16;
			var foundEmpty = false;

			while (true)
			{
				var chunk = LevelData.Chunks[LevelData.Layout.FGLayout[chunkX, chunkY]];
				var block = chunk.Blocks[blockX, objY % LevelData.Level.ChunkHeight / 16];
				var index = LevelData.GetColInd1(block.Block);
				var solid = LevelData.ColArr1[index][block.XFlip ? 15 - solidX : solidX];

				if (solid == 0 || (block.Solid1 & Solidity.TopSolid) == 0)
				{
					objY = objY + 16;
					chunkY = objY / LevelData.Level.ChunkHeight;
					if (chunkY >= LevelData.FGHeight) return 0;
					foundEmpty = true;
				}
				else if (!foundEmpty && solid == 16)
				{
					objY = objY - 16;
					if (objY < 0) return 0;
					chunkY = objY / LevelData.Level.ChunkHeight;
				}
				else
				{
					var height = Math.Abs(index);
					var inverted = block.YFlip ^ solid < 0;
					return (objY & 0xFF0) + (inverted ? -1 : 15 - solid) + overlay.Y;
				}
			}
		}

		private int FindCeiling(ObjectEntry obj)
		{
			var objY = obj.Y + overlay.Top - 1;
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = obj.X / LevelData.Level.ChunkWidth;
			var blockX = obj.X % LevelData.Level.ChunkWidth / 16;
			var solidX = obj.X % 16;
			var foundEmpty = false;

			while (true)
			{
				var chunk = LevelData.Chunks[LevelData.Layout.FGLayout[chunkX, chunkY]];
				var block = chunk.Blocks[blockX, objY % LevelData.Level.ChunkHeight / 16];
				var index = LevelData.GetColInd1(block.Block);
				var solid = LevelData.ColArr1[index][block.XFlip ? 15 - solidX : solidX];

				if (solid == 0 || (block.Solid1 & Solidity.LRBSolid) == 0)
				{
					objY = objY - 16;
					if (objY < 0) return 0;
					chunkY = objY / LevelData.Level.ChunkHeight;
					foundEmpty = true;
				}
				else if (!foundEmpty && solid == 16)
				{
					objY = objY + 16;
					chunkY = objY / LevelData.Level.ChunkHeight;
					if (chunkY >= LevelData.FGHeight) return 0;
				}
				else
				{
					var height = Math.Abs(index);
					var inverted = block.YFlip ^ solid < 0;
					return (objY & 0xFF0) + (inverted ? solid : 16) - overlay.Y;
				}
			}
		}
	}
}

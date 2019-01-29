using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class MagneticSpikeBall : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private IDictionary<byte, string> subtypeNames;
		private Sprite[][] sprites;

		private Sprite overlay;

		public override string Name
		{
			get { return "Magnetic Spike Ball"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var sprite = GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			if (obj.SubType != 0) return sprite;

			var ceiling = FindCeiling(obj);
			if (ceiling == 0) return sprite;

			return new Sprite(sprite, 0, ceiling - obj.Y + 10);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return obj.SubType == 0 ? overlay : null;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType >= 0x80) return base.GetBounds(obj);

			var bounds = overlay.Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return obj.SubType < 0x80 || (obj.SubType & 1) == 0 ? 5 : 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Magnetic Spike Ball.asm", version);
			var tiles = new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(tiles, -6464);
			var art = indexer.ToArray();
			indexer.AddFile(tiles, -6432);
			var art2 = indexer.ToArray();

			var bitmap = new BitmapBits(22, 22);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 21, 21);
			overlay = new Sprite(bitmap, -11, -11);

			subtypeNames = new Dictionary<byte, string>
			{
				{ 0x00, "Ceiling Touch" },
				{ 0x01, "Stationary" },
				{ 0x80, "Sparks" },
				{ 0x81, "Lights" }
			};

			subtypes = new ReadOnlyCollection<byte>(new List<byte>(subtypeNames.Keys));
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 1, false)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 1, 1, true)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art2, map, 5, 1, true))
			};
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
			var index = subtype < 0x80 ? 0 : (subtype & 1) + 1;
			return sprites[index];
		}

		private int FindCeiling(ObjectEntry obj)
		{
			var objY = obj.Y - 11;
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
					return (objY & 0xFF0) + (inverted ? solid : 16);
				}
			}
		}
	}
}

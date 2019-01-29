using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class Ribot : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Ribot"; }
		}

		public override Sprite Image
		{
			get { return sprites[0]; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype >> 1];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprites[subtype == 4 ? 2 : 0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (obj.SubType > 4 || (obj.SubType & 1) != 0)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			if (obj.SubType == 4)
			{
				var sprite = sprites[obj.YFlip ? 3 : 2];
				return BuildSegmentedSprite(sprite, 0, -16, 64, -16, 4);
			}
			else
			{
				var sprite = sprites[obj.YFlip ? 1 : 0];

				if (obj.SubType != 0)
				{
					sprite = BuildSegmentedSprite(sprite, 12, 0, 88, 0, 4);
					return BuildSegmentedSprite(sprite, -12, 0, -24, 0, 4);
				}

				var length = TryTouchFloor(obj.X + 12, obj.Y + 12) - obj.Y;
				sprite = BuildSegmentedSprite(sprite, -12, 0, -12, 12, 4);
				return BuildSegmentedSprite(sprite, 12, 0, 12, length, 4);
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType > 4 || (obj.SubType & 1) != 0)
				return new Rectangle(obj.X - 8, obj.Y - 8, 16, 16);

			return new Rectangle(obj.X - 16, obj.Y - 12, 32, 24);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile("../General/Sprites/Ribot/Ribot.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin("../General/Sprites/Ribot/Map - Ribot.asm", LevelData.Game.MappingsVersion);
			sprites = new Sprite[6];

			sprites[0] = ObjectHelper.MapToBmp(art, map, 0, 1);
			sprites[1] = new Sprite(sprites[0], false, true);
			sprites[2] = ObjectHelper.MapToBmp(art, map, 3, 1);
			sprites[3] = new Sprite(sprites[2], false, true);
			sprites[4] = ObjectHelper.MapToBmp(art, map, 6, 1);
			sprites[5] = ObjectHelper.MapToBmp(art, map, 7, 1);

			subtypeNames = new[]
			{
				"Vertical",
				"Horizontal",
				"Circular"
			};

			var subtypes = new byte[subtypeNames.Length];
			for (var index = 0; index < subtypes.Length; index++)
				subtypes[index] = (byte)(index << 1);

			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite BuildSegmentedSprite(Sprite sprite, int x1, int y1, int x2, int y2, int count)
		{
			for (var index = 1; index < count; index++)
			{
				var x = x1 + index * (x2 - x1) / count;
				var y = y1 + index * (y2 - y1) / count;
				sprite = new Sprite(sprite, new Sprite(sprites[4], x, y));
			}

			return new Sprite(sprite, new Sprite(sprites[5], x2, y2));
		}

		private int TryTouchFloor(int objX, int objY)
		{
			var maxY = objY + sprites[5].Height + 114;
			var floor = FindFloor(objX, objY);
			return floor == 0 || floor > maxY ? maxY : floor;
		}

		private int FindFloor(int objX, int objY)
		{
			objY += sprites[5].Bottom + 1;
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = objX / LevelData.Level.ChunkWidth;
			var blockX = objX % LevelData.Level.ChunkWidth / 16;
			var solidX = objX % 16;

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
				}
				else
				{
					var height = Math.Abs(index);
					var inverted = block.YFlip ^ solid < 0;
					return (objY & 0xFF0) + (inverted ? -1 : 15 - solid) + sprites[5].Y;
				}
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class SpawningSandBlocks : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Spawning Sand Blocks"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
		}

		public override PropertySpec[] CustomProperties
		{
			get { return properties; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return null;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var image = this.sprite[obj.YFlip ? 1 : 0];
			var offset = obj.SubType << 3;
			var sprite = new Sprite(image, offset, 0);

			var x = obj.X + offset;
			var y = FindFloor(x, obj.Y + 9);
			var threshold = obj.X - offset + 1;

			for (var wait = (x - threshold) & 127; x > threshold; wait--)
			{
				if (wait == 0)
				{
					sprite = new Sprite(sprite, new Sprite(image, x - obj.X, y - obj.Y));
					wait = 128;
				}

				y = FindFloor(--x, y + 1);
			}

			return new Sprite(sprite, new Sprite(image, x - obj.X, y - obj.Y));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprite[0].Bounds;
			bounds.Offset(obj.X + (obj.SubType << 3), obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Tile.bin", CompressionType.Nemesis),
				"../Levels/SOZ/Misc Object Data/Map - Spawning Sand Blocks.asm", 0, 2));

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Horizontal distance spawned blocks will travel, in pixels.", null,
				(obj) => (obj.SubType << 3),
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, false, true) };
		}

		private int FindFloor(int objX, int objY)
		{
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = objX / LevelData.Level.ChunkWidth;
			var blockX = objX % LevelData.Level.ChunkWidth / 16;
			var solidX = objX % 16;
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
					return (objY & 0xFF0) + (inverted ? -1 : 15 - solid);
				}
			}
		}
	}
}

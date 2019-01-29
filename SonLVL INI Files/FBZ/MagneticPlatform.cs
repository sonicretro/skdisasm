using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class MagneticPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Magnetic Platform"; }
		}

		public override Sprite Image
		{
			get { return image; }
		}

		public override PropertySpec[] CustomProperties
		{
			get { return properties; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override byte DefaultSubtype
		{
			get { return 2; }
		}

		public override string SubtypeName(byte subtype)
		{
			return null;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return image;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var sprite = new Sprite(sprites[0], obj.XFlip, obj.YFlip);
			var segment = new Sprite(sprites[1], obj.XFlip, obj.YFlip);
			var length = obj.Y - TryTouchCeiling(obj);

			while (length > 0)
			{
				sprite.Offset(0, -16);
				sprite = new Sprite(sprite, segment);
				length -= 16;
			}

			sprite.Offset(0, -length);
			return new Sprite(sprite, new Sprite(sprites[2], 0, 12, obj.XFlip, obj.YFlip));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprites[0].Bounds;
			bounds.Offset(obj.X, TryTouchCeiling(obj));
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -6464);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Magnetic Platform.asm", version);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 0, 1),
				ObjectHelper.MapToBmp(art, map, 1, 1),
				ObjectHelper.MapToBmp(art, map, 3, 1)
			};

			image = ObjectHelper.MapToBmp(art, map, 4, 1);
			sprites[1].Offset(0, 8);

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The vertical range of the object's chain, in pixels.", null,
				(obj) => obj.SubType << 4,
				(obj, value) => obj.SubType = (byte)((int)value >> 4));
		}

		private int TryTouchCeiling(ObjectEntry obj)
		{
			var minY = obj.Y + sprites[0].Height - obj.SubType * 16;
			var ceiling = FindCeiling(obj);
			return ceiling == 0 || ceiling < minY ? minY : ceiling;
		}

		private int FindCeiling(ObjectEntry obj)
		{
			var objY = obj.Y + sprites[0].Top - 1;
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
					return (objY & 0xFF0) + (inverted ? solid : 16) - sprites[0].Y;
				}
			}
		}
	}
}

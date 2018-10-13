using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class RotatingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;
		private Sprite block;

		public override string Name
		{
			get { return "Rotating Blocks"; }
		}

		public override Sprite Image
		{
			get { return block; }
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
			return block;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = obj.SubType & 0x0F;
			if (index == 0x0F) return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			return sprites[index];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = obj.SubType & 0x0F;
			var count = index == 0x0F ? 0 : index < 9 ? 3 - index / 3 : 7 - (index - 1) / 2;
			var radius = count * 24 + 20;

			var bitmap = new BitmapBits(radius * 2 + 1, radius * 2 + 1);
			bitmap.DrawCircle(LevelData.ColorWhite, radius, radius, radius);
			return new Sprite(bitmap, -radius, -radius);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Rotating Platform.asm", LevelData.Game.MappingsVersion);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -7744);
			block = ObjectHelper.MapToBmp(indexer.ToArray(), map, 0, 1);
			var block1 = new Sprite(block, 44, 0);
			var block2 = new Sprite(block1, 24, 0);
			var block3 = new Sprite(block2, 24, 0);
			var block4 = new Sprite(block, -44, 0);
			var block5 = new Sprite(block4, -24, 0);
			var block6 = new Sprite(block5, -24, 0);

			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -6464);
			var spike = ObjectHelper.MapToBmp(indexer.ToArray(), map, 1, 1);
			var spike1 = new Sprite(spike, 44, 0);
			var spike2 = new Sprite(spike1, 24, 0);
			var spike3 = new Sprite(spike2, 24, 0);
			var spike4 = new Sprite(spike, -44, 0);
			var spike5 = new Sprite(spike4, -24, 0);
			var spike6 = new Sprite(spike5, -24, 0);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				new Sprite(block1, block2, block3, block4, block5, block6),
				new Sprite(block1, block2, spike3, block4, block5, block6),
				new Sprite(block1, block2, spike3, block4, block5, spike6),
				new Sprite(block1, block2, block4, block5),
				new Sprite(block1, spike2, block4, block5),
				new Sprite(block1, spike2, block4, spike5),
				new Sprite(block1, block4),
				new Sprite(spike1, block4),
				new Sprite(spike1, spike4),
				new Sprite(block1, block2, block3),
				new Sprite(block1, block2, spike3),
				new Sprite(block1, block2),
				new Sprite(block1, spike2),
				new Sprite(block1),
				new Sprite(spike1)
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Single", typeof(bool), "Extended",
				"If set, the object will only have a single bar of blocks.", null,
				(obj) =>
				{
					var index = obj.SubType & 0x0F;
					return index != 0x0F && index >= 9;
				},
				(obj, value) =>
				{
					var index = obj.SubType & 0x0F;
					var single = (bool)value;

					if ((single ^ index >= 9) && index != 0x0F)
					{
						if (single)
							obj.SubType = (byte)((index + 14) * 2 / 3);
						else
							obj.SubType = (byte)(index * 3 / 2 - 13);
					}
				});

			properties[1] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of rotating blocks in each bar.", null,
				(obj) =>
				{
					var index = obj.SubType & 0x0F;
					if (index == 0x0F) return 0;

					return index < 9 ? 3 - index / 3 : 7 - (index - 1) / 2;
				},
				(obj, value) =>
				{
					var index = obj.SubType & 0x0F;
					var count = 3 - (int)value;

					if (count >= 0 && count < 3)
					{
						if (index == 0x0F)
							obj.SubType = (byte)(count * 3);
						else if (index < 9)
							obj.SubType = (byte)(count * 3 + (index % 3));
						else
							obj.SubType = (byte)(count * 2 + (index % 2 ^ 1) + 9);
					}
				});

			properties[2] = new PropertySpec("Spike Ball", typeof(int), "Extended",
				"If set, the last block of each bar will be a spike ball.", null, new Dictionary<string, int>
				{
					{ "None", 0 },
					{ "Single", 1 },
					{ "Double", 2 }
				},
				(obj) =>
				{
					var index = obj.SubType & 0x0F;
					return index < 9 ? index % 3 : (index - 1) % 2;
				},
				(obj, value) =>
				{
					var index = obj.SubType & 0x0F;
					var count = (int)value;

					if (count >= 0 && count < 3 && index != 0x0F)
					{
						if (index < 9)
							obj.SubType = (byte)(index / 3 * 3 + count);
						else
							obj.SubType = (byte)((index - 1) / 2 * 2 + (count == 0 ? 1 : 2));
					}
				});
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

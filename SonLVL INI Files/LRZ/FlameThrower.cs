using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class FlameThrower : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Flamethrower"; }
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
			var vertical = obj.SubType >= 0x80;
			return sprites[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0) | (vertical ? 4 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var vertical = obj.SubType >= 0x80;
			return new Rectangle(obj.X - (vertical ? 16 : 24), obj.Y - 16, vertical ? 32 : 48, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Flamethrower.asm", version);
			var art = LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis);

			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 0, 1),
				ObjectHelper.MapToBmp(art, map, 2, 1),
				ObjectHelper.MapToBmp(art, map, 4, 1),
			};

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -4608);
			art = indexer.ToArray();

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			image = ObjectHelper.MapToBmp(art, map, 6, 1);

			var vertical = ObjectHelper.MapToBmp(art, map, 7, 1);
			sprites = new[]
			{
				new Sprite(image,
					new Sprite(sprites[0], 32, 4), new Sprite(sprites[0], 48, 6),
					new Sprite(sprites[1], 64, 6), new Sprite(sprites[1], 80, 4),
					new Sprite(sprites[2], 96, 0), new Sprite(sprites[2], 112, -8)),

				new Sprite(new Sprite(image, false, true),
					new Sprite(sprites[0], 32, 4, false, true), new Sprite(sprites[0], 48, 6, false, true),
					new Sprite(sprites[1], 64, 6, false, true), new Sprite(sprites[1], 80, 4, false, true),
					new Sprite(sprites[2], 96, 0, false, true), new Sprite(sprites[2], 112, -8, false, true)),

				new Sprite(vertical,
					new Sprite(sprites[0], -4, 32), new Sprite(sprites[0], -6, 48),
					new Sprite(sprites[1], -6, 64), new Sprite(sprites[1], -4, 80),
					new Sprite(sprites[2], -0, 96), new Sprite(sprites[2], 8, 112)),

				new Sprite(new Sprite(vertical, false, true),
					new Sprite(sprites[0], -4, 32, false, true), new Sprite(sprites[0], -6, 48, false, true),
					new Sprite(sprites[1], -6, 64, false, true), new Sprite(sprites[1], -4, 80, false, true),
					new Sprite(sprites[2], -0, 96, false, true), new Sprite(sprites[2], 8, 112, false, true)),

				new Sprite(new Sprite(vertical, true, true),
					new Sprite(sprites[0], 4, -32, true, true), new Sprite(sprites[0], 6, -48, true, true),
					new Sprite(sprites[1], 6, -64, true, true), new Sprite(sprites[1], 4, -80, true, true),
					new Sprite(sprites[2], 0, -96, true, true), new Sprite(sprites[2], -8, -112, true, true))
			};

			sprites = new[]
			{
				sprites[0], new Sprite(sprites[0], true, false),
				sprites[1], new Sprite(sprites[1], true, false),
				sprites[2], sprites[4], sprites[3], sprites[4]
			};

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait between bursts.", null,
				(obj) => (obj.SubType & 0x7F) << 2,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 2) & 0x7F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x80 },
					{ "Horizontal", 0x00 }
				},
				(obj) => obj.SubType & 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80)));
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class EnergyBridgeCurved : EnergyBridge
	{
		public override string Name
		{
			get { return "Energy Bridge (curved)"; }
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 64, obj.Y - 32, 136, 72);
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/DEZ/Misc Object Data/Map - Energy Bridge Curved.asm");
		}
	}

	class EnergyBridge : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Energy Bridge"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 64, obj.Y - 8, 128, 8);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 6;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/DEZ/Misc Object Data/Map - Energy Bridge.asm");
		}

		protected void BuildSpritesProperties(string mapfile)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -5696);

			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(mapfile, LevelData.Game.MappingsVersion);
			var sprites = new Sprite[4];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 1);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(sprites);

			properties[0] = new PropertySpec("On Period", typeof(int), "Extended",
				"How long the object remains solid for, in frames.", null, new Dictionary<string, int>
				{
					{ "64", 0x40 },
					{ "96", 0x60 },
					{ "128", 0x80 },
					{ "160", 0xA0 },
				},
				(obj) => ((obj.SubType & 3) + 2) << 5,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFC) | ((((int)value >> 5) - 2) & 3)));

			properties[1] = new PropertySpec("Period", typeof(int), "Extended",
				"How duration of the object's on/off cycle, in frames.", null, new Dictionary<string, int>
				{
					{ "128", 0x80 },
					{ "256", 0x100 },
					{ "512", 0x200 },
					{ "1024", 0x400 },
				},
				(obj) => 1 << (((obj.SubType & 0x0C) >> 2) + 7),
				(obj, value) =>
				{
					var log = (int)Math.Log((int)value, 2);
					obj.SubType = (byte)((obj.SubType & 0xF3) | (((log - 7) << 2) & 0x0C));
				});

			properties[2] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's on/off cycle.", null,
				(obj) => (1 << (((obj.SubType & 0x0C) >> 2) + 3)) * (obj.SubType >> 4),
				(obj, value) =>
				{
					var div = 1 << (((obj.SubType & 0x0C) >> 2) + 3);
					obj.SubType = (byte)((obj.SubType & 0x0F) | (((int)value / div) << 4));
				});
		}
	}
}

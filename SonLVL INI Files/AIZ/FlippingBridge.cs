using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class FlippingBridge : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Flipping Bridge"; }
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
			get { return 0x52; }
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
			return sprites[obj.SubType >> 7];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../Levels/AIZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/AIZ/Misc Object Data/Map - Flipping Bridge.asm", version);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			image = ObjectHelper.MapToBmp(art, map, 5, 2);

			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 1, 2),
				ObjectHelper.MapToBmp(art, map, 3, 2)
			};

			sprites = new[]
			{
				new Sprite(new Sprite(image, -112, 32), new Sprite(image, -80, 24),
					new Sprite(image, -48, 16), new Sprite(sprites[0], -16, 8), new Sprite(sprites[1], 16, 0),
					new Sprite(image, 48, -8), new Sprite(image, 80, -16), new Sprite(image, 112, -24)),
				new Sprite(new Sprite(image, -112, 16), new Sprite(image, -80, 12),
					new Sprite(image, -48, 8), new Sprite(sprites[0], -16, 4), new Sprite(sprites[1], 16, 0),
					new Sprite(image, 48, -4), new Sprite(image, 80, -8), new Sprite(image, 112, -12))
			};

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How long the object will wait at the end of its animation.", null,
				(obj) => (obj.SubType & 0x0F) * 6,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value / 6) & 0x0F)));

			properties[1] = new PropertySpec("Period", typeof(int), "Extended",
				"How long the object will wait at each step of its animation.", null,
				(obj) => ((obj.SubType & 0x70) >> 4) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((((int)value - 1) << 4) & 0x70)));

			properties[2] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The object's angle and the direction of its animation.", null, new Dictionary<string, int>
				{
					{ "Steep, right-to-left", 0x00 },
					{ "Steep, left-to-right", 0x01 },
					{ "Shallow, right-to-left", 0x80 },
					{ "Shallow, left-to-right", 0x81 },
				},
				(obj) => (obj.SubType & 0x80) | (obj.XFlip ? 1 : 0),
				(obj, value) =>
				{
					obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80));
					obj.XFlip = ((int)value & 1) == 1; 
				});
		}
	}
}

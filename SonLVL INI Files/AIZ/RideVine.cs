using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class RideVine : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Sliding Vine"; }
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

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var x = (obj.SubType & 0x7F) << 4;
			var y = x >> 2;

			var overlay = new BitmapBits(x, y);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, x, y);
			var sprite = new Sprite(overlay, 0, 0x41);

			overlay = new BitmapBits(1, 0x41);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x00, 0, 0x07);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x10, 0, 0x17);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x20, 0, 0x27);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x30, 0, 0x37);
			sprite = new Sprite(sprite, new Sprite(overlay, x, y));

			if ((obj.SubType & 0x80) == 0)
			{
				overlay = new BitmapBits(0x81, 0x81);
				overlay.DrawCircle(LevelData.ColorWhite, 0x40, 0x40, 0x40);
				sprite = new Sprite(sprite, new Sprite(overlay, x - 0x40, y - 0x40));
			}

			return sprite;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/AIZ/Nemesis Art/Swing Vine.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/AIZ/Misc Object Data/Map - (&MHZ) Ride Vine.asm", version);
			var sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 32, 0),
				ObjectHelper.MapToBmp(art, map, 2, 0),
				ObjectHelper.MapToBmp(art, map, 1, 0),
				ObjectHelper.MapToBmp(art, map, 1, 0),
				ObjectHelper.MapToBmp(art, map, 0, 0),
				ObjectHelper.MapToBmp(art, map, 33, 0)
			};

			sprites[3].Offset(0, 16);
			sprites[2].Offset(-3, 32);
			sprites[1].Offset(-6, 48);
			sprites[0].Offset(-12, 63);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(sprites);

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Horizontal distance the object will travel, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 4) & 0x7F)));

			properties[1] = new PropertySpec("Action", typeof(int), "Extended",
				"The object's behavior upon reaching the end of its path.", null, new Dictionary<string, int>
				{
					{ "Spin around", 0x00 },
					{ "Catch on fire", 0x80 }
				},
				(obj) => obj.SubType & 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80)));
		}
	}
}

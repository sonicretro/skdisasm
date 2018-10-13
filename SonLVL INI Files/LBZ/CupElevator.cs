using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class CupElevator : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Cup Elevator"; }
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
			return sprites[obj.XFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var up = (obj.SubType & 0x30) == 0;
			var height = (obj.SubType & 0x0F) * 96 + 32;
			int xoffset, width; bool left;

			if (obj.SubType >= 0x80)
			{
				left = up && obj.XFlip;
				var distance = up ? obj.XFlip ? obj.X - 0x2AE0 : 0x16C0 - obj.X : 0x2B20 - obj.X;
				xoffset = left ? distance + 32 : distance > 32 ? 0 : 32 - distance;
				width = distance > 32 ? distance + (left ? 33 : 32) : 64;
			}
			else
			{
				left = ((obj.SubType & 1) == 0) ^ obj.XFlip;
				xoffset = left ? 96 : 0;
				width = left ? 97 : 96;
			}

			var overlay = new BitmapBits(width, height);
			overlay.DrawLine(LevelData.ColorWhite, xoffset, 0, xoffset, height);

			var x = left ? 0 : width - 64;
			if (up) overlay.DrawRectangle(LevelData.ColorWhite, x, 0, 63, 31);
			else overlay.DrawRectangle(LevelData.ColorWhite, x, height - 32, 63, 31);

			if (width > 64)
			{
				var y = up ? 16 : height - 16;
				if (left) overlay.DrawLine(LevelData.ColorWhite, 64, y, width, y);
				else overlay.DrawLine(LevelData.ColorWhite, 0, y, width - 64, y);
			}

			return new Sprite(overlay, -xoffset, up ? 16 - height : -16);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X + (obj.XFlip ? 32 : -96), obj.Y - 16, 64, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -2368);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/LBZ/Misc Object Data/Map - Cup Elevator.asm", LevelData.Game.MappingsVersion);

			image = ObjectHelper.MapToBmp(art, map, 0, 2);
			var sprite = new Sprite(ObjectHelper.MapToBmp(art, map, 1, 2), new Sprite(image, -40, 0));
			sprite.Offset(-24, 0);
			sprite = new Sprite(ObjectHelper.MapToBmp(art, map, 2, 2), sprite);

			properties = new PropertySpec[4];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[] { sprite, new Sprite(sprite, true, false) };

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"The vertical range of the object's movement pattern.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The direction of the object's initial movement.", null, new Dictionary<string, int>
				{
					{ "Up", 0x00 },
					{ "Down", 0x10 }
				},
				(obj) => (obj.SubType & 0x30) == 0 ? 0x00 : 0x10,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xCF) | ((int)value & 0x30)));

			properties[2] = new PropertySpec("Sonic only", typeof(bool), "Extended",
				"If set, the object disappears when playing as Knuckles.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));

			properties[3] = new PropertySpec("Launch", typeof(bool), "Extended",
				"If set, the object will fly off at the end of its movement.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
		}
	}
}

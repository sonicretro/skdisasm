using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class DashElevator : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Dash Elevator"; }
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
			var height = (obj.SubType & 0x7F) << 3;
			var offset = obj.SubType >= 0x80;

			if (!offset) return sprite;
			return new Sprite(sprite, 0, obj.XFlip ? -32 : 32);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var height = (obj.SubType & 0x7F) << 3;
			if (height == 0) return null;

			var overlay = new BitmapBits(32, height + 1);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, 31, 0);
			overlay.DrawLine(LevelData.ColorWhite, 16, 0, 16, height);
			overlay.DrawLine(LevelData.ColorWhite, 0, height, 31, height);

			return new Sprite(overlay, -16, obj.XFlip ? -height - 4 : -4);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis),
				"../Levels/LRZ/Misc Object Data/Map - Dash Elevator.asm", 0, 0);

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Vertical distance the object will travel, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 3,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 3) & 0x7F)));

			properties[1] = new PropertySpec("Offset", typeof(bool), "Extended",
				"If set, the lift will spawn 32px away from the end of its rail.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class SnakeBlocks : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Snake Block"; }
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
			var subtype = obj.SubType & 0x7F;
			var radians = Math.PI * (subtype / 128.0);
			var offset = (int)(Math.Cos(radians) * 64.0);

			if ((obj.SubType & 0x80) != 0)
				if (obj.YFlip)
					return obj.XFlip ? new Sprite(sprite, offset, 64) : new Sprite(sprite, 64, -offset);
				else
					return obj.XFlip ? new Sprite(sprite, -offset, -64) : new Sprite(sprite, -64, offset);
			else
				if (obj.YFlip)
					return obj.XFlip ? new Sprite(sprite, -64, offset) : new Sprite(sprite, offset, 64);
				else
					return obj.XFlip ? new Sprite(sprite, 64, -offset) : new Sprite(sprite, -offset, -64);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/HCZ/Nemesis Art/Act 2 Block Platform.bin", CompressionType.Nemesis),
				"../Levels/HCZ/Misc Object Data/Map - Floating Platform.asm", 1, 0);

			var bitmap = new BitmapBits(129, 129);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 128, 128);
			overlay = new Sprite(bitmap, -64, -64);

			properties[0] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will move counterclockwise.", null,
				(obj) => (obj.SubType & 0x80) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));

			properties[1] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's movement cycle.", null,
				(obj) => obj.SubType & 0x7F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | ((int)value & 0x7F)));
		}
	}
}

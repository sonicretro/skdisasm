using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class GateLaser : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Gate Laser"; }
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
			var height = (obj.SubType & 0x0F) << 3;
			if (height == 0) return overlay;

			return new Sprite(overlay, 0, height);
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
				"../Levels/LBZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis),
				"../Levels/LBZ/Misc Object Data/Map - Gate Laser.asm", 0, 2);

			var bitmap = new BitmapBits(sprite.Width, sprite.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, sprite.Width - 1, sprite.Height - 1);
			overlay = new Sprite(bitmap, sprite.X, sprite.Y);

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"How far the object will fall before disappearing, in pixels.", null,
				(obj) => (obj.SubType & 0x0F) << 3,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value >> 3) & 0x0F)));

			properties[1] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait before respawning.", null,
				(obj) => (obj.SubType & 0xF0) >> 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | (((int)value << 1) & 0xF0)));
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class Updraft : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Updraft"; }
		}

		public override bool Debug
		{
			get { return true; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var range = ((obj.SubType & 0x7F) << 3) + 8;
			var height = range > 64 ? range : 64;
			range = height - range;

			var overlay = new BitmapBits(128, height);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, height - 64, 127, 63);
			overlay.DrawLine(LevelData.ColorWhite, 0, range, 128, range);

			if (range < 48) overlay.DrawLine(LevelData.ColorWhite, 64, range, 64, height - 16);
			return new Sprite(overlay, -64, 8 - height);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 64, obj.Y - 56, 128, 64);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Height at which a mushroom parachute will float, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 3,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 3) & 0x7F)));

			properties[1] = new PropertySpec("Twirl", typeof(bool), "Extended",
				"If set, the object will trigger the player's twirl animation.", null,
				(obj) => (obj.SubType & 0x80) == 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0 : 0x80)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class FlybotAlarm : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Flybot767 Alarm"; }
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
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = overlay.Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			var bitmap = new BitmapBits(64, 32);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 63, 31);
			overlay = new Sprite(bitmap, -32, -16);

			properties[0] = new PropertySpec("Delayed", typeof(bool), "Extended",
				"If set, the Flybot will appear 40 frames after the alarm.", null,
				(obj) => (obj.SubType & 1) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFE) | ((bool)value ? 1 : 0)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The side of the screen from which the Flybot will appear.", null, new Dictionary<string, int>
				{
					{ "Right", 0 },
					{ "Left", 2 }
				},
				(obj) => obj.SubType & 0xFE,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 1) | ((int)value & 2)));
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

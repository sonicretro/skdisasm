using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class GravityHub : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Gravity Hub"; }
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
			var bounds = GetBounds(obj);
			var bitmap = new BitmapBits(bounds.Width, bounds.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);
			return new Sprite(bitmap, -bounds.Width / 2, -bounds.Height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 32, obj.Y - 32, 64, 64);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[4];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Exit Up", typeof(bool), "Extended",
				"If set, the player can escape the object by pressing up.", null,
				(obj) => (obj.SubType & 1) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0E) | ((bool)value ? 1 : 0)));

			properties[1] = new PropertySpec("Exit Down", typeof(bool), "Extended",
				"If set, the player can escape the object by pressing down.", null,
				(obj) => (obj.SubType & 2) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0D) | ((bool)value ? 2 : 0)));

			properties[2] = new PropertySpec("Exit Left", typeof(bool), "Extended",
				"If set, the player can escape the object by pressing left.", null,
				(obj) => (obj.SubType & 4) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0B) | ((bool)value ? 4 : 0)));

			properties[3] = new PropertySpec("Exit Right", typeof(bool), "Extended",
				"If set, the player can escape the object by pressing right.", null,
				(obj) => (obj.SubType & 8) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x07) | ((bool)value ? 8 : 0)));
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

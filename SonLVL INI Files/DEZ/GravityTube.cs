using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class GravityTube : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Gravity Tube"; }
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
			if ((obj.SubType & 0x3F) == 0) return null;

			var bounds = GetBounds(obj);
			var bitmap = new BitmapBits(bounds.Width, bounds.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);
			return new Sprite(bitmap, -bounds.Width / 2, -bounds.Height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if ((obj.SubType & 0x3F) == 0) return base.GetBounds(obj);
			var length = (obj.SubType & 0x3F) << 4;

			if (obj.SubType >= 0x80)
				return new Rectangle(obj.X - 32, obj.Y - (length / 2), 64, length);

			var height = (obj.SubType & 0x40) == 0 ? 64 : 192;
			return new Rectangle(obj.X - (length / 2), obj.Y - (height / 2), length, height);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0 },
					{ "Horizontal (wide)", 0x40 },
					{ "Vertical", 0x80 }
				},
				(obj) => (obj.SubType & 0x80) != 0 ? 0x80 : (obj.SubType & 0xC0),
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x3F) | ((int)value & 0xC0)));

			properties[1] = new PropertySpec("Length", typeof(int), "Extended",
				"The range of the object, in pixels.", null,
				(obj) => (obj.SubType & 0x3F) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xC0) | (((int)value >> 4) & 0x3F)));
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

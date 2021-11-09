using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class WireCage : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Wire Cylinder"; }
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
			var length = (obj.SubType & 0x7F) << 4;

			if (obj.SubType < 0x80)
			{
				var bitmap = new BitmapBits(length, 128);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, length - 1, 127);
				return new Sprite(bitmap, -length / 2, -64);
			}
			else
			{
				var bitmap = new BitmapBits(256, length);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 255, length - 1);
				return new Sprite(bitmap, -128, -length / 2);
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var length = (obj.SubType & 0x7F) << 4;
			if (length == 0) return base.GetBounds(obj);

			if (obj.SubType < 0x80)
				return new Rectangle(obj.X - (length / 2), obj.Y - 64, length, 128);
			else
				return new Rectangle(obj.X - 128, obj.Y - (length / 2), 256, length);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0x00 },
					{ "Vertical", 0x80 }
				},
				(obj) => obj.SubType < 0x80 ? 0x00 : 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80)));

			properties[1] = new PropertySpec("Length", typeof(int), "Extended",
				"The range of the object, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 4) & 0x7F)));
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

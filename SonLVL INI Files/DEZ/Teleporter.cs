using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class Teleporter : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Teleporter"; }
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
			var reverse = (obj.SubType < 0x80) ^ obj.YFlip;
			var distance = ((obj.SubType & 0x7F) << 4) + (reverse ? 16 : 9);

			var bitmap = new BitmapBits(40, distance + 39);
			var y = bitmap.Height - 48;
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 38);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, y, 39, 47);

			if (distance > 47)
			{
				var x = obj.XFlip ? 15 : 16;
				bitmap.DrawLine(LevelData.ColorWhite, x, 39, x, y);
			}

			var overlay = new Sprite(bitmap, -16, obj.YFlip ? -19 : -20);
			overlay.Flip(obj.XFlip, !obj.YFlip);
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 16, obj.Y - 19, 32, 39);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Vertical distance the player will travel, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value >> 4) & 0x7F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The direction of the player's movement.", null, new Dictionary<string, int>
				{
					{ "Up", 0 },
					{ "Down", 1 }
				},
				(obj) => obj.YFlip ? 1 : 0,
				(obj, value) => obj.YFlip = (int)value == 1);

			properties[2] = new PropertySpec("Target", typeof(int), "Extended",
				"The player's orientation at the end of their movement.", null, new Dictionary<string, int>
				{
					{ "Floor, right", 0x00 },
					{ "Floor, left", 0x01 },
					{ "Ceiling, right", 0x80 },
					{ "Ceiling, left", 0x81 }
				},
				(obj) => (obj.SubType & 0x80) | (obj.XFlip ? 1 : 0),
				(obj, value) =>
				{
					obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80));
					obj.XFlip = (int)value == 1;
				});
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class Quicksand : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Quicksand"; }
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
			var direction = obj.SubType & 0xC0;
			var width = (obj.SubType & 0x3F) << 4;
			if (width == 0) return base.GetBounds(obj);

			var height = width;
			if (direction == 0x00) width = 32;
			else if (direction == 0x40) height = 32;
			else if (direction == 0x80) width = 64;
			else if (direction == 0xC0) height = 64;

			return new Rectangle(obj.X - (width / 2), obj.Y - (height / 2), width, height);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The player's behavior and movement direction.", null, new Dictionary<string, int>
				{
					{ "Spin (up)", 0x02 },
					{ "Spin (down)", 0x00 },
					{ "Spin (left)", 0x41 },
					{ "Spin (right)", 0x40 },
					{ "Twirl (up)", 0x82 },
					{ "Twirl (down)", 0x80 },
					{ "Walk (up)", 0xC2 },
					{ "Walk (down)", 0xC0 }
				},
				(obj) =>
				{
					var direction = obj.SubType & 0xC0;
					if (direction == 0x40) return obj.XFlip ? 0x41 : 0x40;
					return direction | (obj.YFlip ? 2 : 0);
				},
				(obj, value) =>
				{
					obj.SubType = (byte)((obj.SubType & 0x3F) | ((int)value & 0xC0));
					obj.XFlip = ((int)value & 1) != 0;
					obj.YFlip = ((int)value & 2) != 0;
				});

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

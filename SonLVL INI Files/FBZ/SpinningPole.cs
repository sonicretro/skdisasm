using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class SpinningPole : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Spinning Pole"; }
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
			var length = (obj.SubType << 3) + 16;
			var bitmap = new BitmapBits(16, length);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 15, length - 1);
			return new Sprite(bitmap, -8, 8 - length);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var length = (obj.SubType << 3) + 16;
			return new Rectangle(obj.X - 8, obj.Y + 8 - length, 16, length);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The range of the object, in pixels.", null,
				(obj) => (obj.SubType << 3) + 16,
				(obj, value) => obj.SubType = (byte)(((int)value - 16) >> 3));
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

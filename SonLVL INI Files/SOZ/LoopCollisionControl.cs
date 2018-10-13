using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class LoopCollisionControl : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Loop Collision Control"; }
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
			var range = ((obj.SubType & 0x7F) << 4) + 15;
			var height = range < 32 ? 32 : range + 1;

			var overlay = new BitmapBits(32, height);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 31);
			overlay.DrawLine(LevelData.ColorWhite, 0, range, 31, range);

			if (height > 32) overlay.DrawLine(LevelData.ColorWhite, 16, 32, 16, height);
			return new Sprite(overlay, -16, -16);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 16, obj.Y - 16, 32, 32);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Distance at which collision is restored, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 4,
				(obj, value) => obj.SubType = (byte)(((int)value >> 4) & 0x7F));
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

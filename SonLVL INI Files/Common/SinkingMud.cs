using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class SinkingMud2P : SinkingMud
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(0x30);
		}
	}

	class SinkingMud : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private int height;

		public override string Name
		{
			get { return "Sinking Mud"; }
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
			var width = obj.SubType << 4;
			var overlay = new BitmapBits(width, height);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, width - 1, height - 1);
			return new Sprite(overlay, -width / 2, -height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var width = obj.SubType << 4;
			if (width == 0) return base.GetBounds(obj);

			return new Rectangle(obj.X - (width / 2), obj.Y - (height / 2), width, height);
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(0x60);
		}

		protected void BuildSpritesProperties(int height)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			this.height = height;

			properties[0] = new PropertySpec("Width", typeof(int), "Extended",
				"The width of the object, in pixels.", null,
				(obj) => obj.SubType << 4,
				(obj, value) => obj.SubType = (byte)((int)value >> 4));
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

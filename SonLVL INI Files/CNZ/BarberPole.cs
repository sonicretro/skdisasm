using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CNZ
{
	class BarberPole : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] overlay;

		public override string Name
		{
			get { return "Barber Pole"; }
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
			return overlay[obj.SubType == 0 ? 0 : 1];
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			overlay = new Sprite[2];
			var bitmap = new BitmapBits(161, 161);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 32, 32, 0);
			bitmap.DrawLine(LevelData.ColorWhite, 32, 0, 160, 128);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 32, 128, 160);
			bitmap.DrawLine(LevelData.ColorWhite, 128, 160, 160, 128);
			overlay[0] = new Sprite(bitmap, -80, -80);
			overlay[1] = new Sprite(overlay[0], true, false);

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Left", 0 },
					{ "Right", 1 }
				},
				(obj) => obj.SubType == 0 ? 1 : 0,
				(obj, value) => obj.SubType = (byte)((int)value == 0 ? 1 : 0));
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

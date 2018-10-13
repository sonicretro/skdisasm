using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class TwistingLoop : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Twisting Loop Control"; }
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
			var height = obj.SubType << 4;
			var bitmap = new BitmapBits(97, height + 1);
			bitmap.DrawSine(LevelData.ColorWhite, 48, -48, 48, 192, height + 48);
			bitmap.DrawSine(LevelData.ColorWhite, 48, -144, 48, 192, height + 144);

			return new Sprite(bitmap, -48, 0);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The range of the object, in pixels.", null,
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

	public static class BitmapBitsExtensions
	{
		public static void DrawSine(this BitmapBits bitmap, byte index, int x, int y, int amplitude, int period, int height)
		{
			int x1 = x, y2 = y;
			int max = height + y;

			while (y2 < max)
			{
				var y1 = y2++;
				var radians = (y2 - y) * 2 * Math.PI / period;
				var x2 = x + (int)Math.Round(amplitude * Math.Sin(radians));
				bitmap.DrawLine(index, x1, y1, x2, y2);
				x1 = x2;
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class WireCageRide : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Wire Cylinder Ride Control"; }
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
			if (obj.SubType == 0)
			{
				var bitmap = new BitmapBits(225, 39);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 0, 38);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 19, 224, 19);
				bitmap.DrawLine(LevelData.ColorWhite, 224, 0, 224, 38);
				return new Sprite(bitmap, -112, -19);
			}
			else
			{
				var height = obj.SubType << 8;
				var bitmap = new BitmapBits(225, height + 39);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 0, 38);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 19, 112, 19);
				bitmap.DrawSine(LevelData.ColorWhite, 112, 19, 112, 128, height);
				bitmap.DrawLine(LevelData.ColorWhite, 112, height + 19, 224, height + 19);
				bitmap.DrawLine(LevelData.ColorWhite, 224, height, 224, height + 38);

				if (!obj.XFlip) return new Sprite(bitmap, -112, -19);

				var overlay = new Sprite(bitmap, -113, -20);
				overlay.Flip(true, true);
				return overlay;
			}
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"How many times the player will loop around the object.", null,
				(obj) => obj.SubType << 1,
				(obj, value) => obj.SubType = (byte)((int)value >> 1));
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

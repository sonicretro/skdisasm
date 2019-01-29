using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class HollowTree : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Tree Ride Control"; }
		}

		public override bool Debug
		{
			get { return true; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			var bitmap = new BitmapBits(225, 289);
			bitmap.DrawSine(LevelData.ColorWhite, 112, -32, 112, 128, 320);
			return new Sprite(bitmap, -112, -144);
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
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

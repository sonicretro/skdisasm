using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CNZ
{
	class SpiralTube : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] unknownSprite;

		private Point[] startCoords;
		private Sprite[] paths;
		private Sprite overlay;

		public override string Name
		{
			get { return "Spiral Tube Control"; }
		}

		public override bool Debug
		{
			get { return true; }
		}

		public override Sprite Image
		{
			get { return unknownSprite[0]; }
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
			return unknownSprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType > 2) return null;

			int minX = obj.X, maxX = obj.X, minY = obj.Y + 384, maxY = obj.Y + 384;
			for (var index = 0; index < 2; index++)
			{
				var coord = startCoords[obj.SubType + index];
				if (coord.X < minX) minX = coord.X; else if (coord.X > maxX) maxX = coord.X;
				if (coord.Y < minY) minY = coord.Y; else if (coord.Y > maxY) maxY = coord.Y;
			}

			var white = new BitmapBits(maxX - minX + 1, maxY - minY + 1);
			var black = new BitmapBits(white.Width + 1, white.Height + 1);
			int x1 = obj.X - minX, y1 = obj.Y - minY + 384;

			for (var index = 0; index < 2; index++)
			{
				var coord = startCoords[obj.SubType + index];
				int x2 = coord.X - minX, y2 = coord.Y - minY;

				white.DrawLine(LevelData.ColorWhite, x1, y1, x2, y2);
				black.DrawLine(LevelData.ColorBlack, x1, y1 + 1, x2, y2 + 1);
				black.DrawLine(LevelData.ColorBlack, x1 + 1, y1, x2 + 1, y2);
				black.DrawLine(LevelData.ColorBlack, x1 + 1, y1 + 1, x2 + 1, y2 + 1);
			}

			var overlay = new Sprite(
				new Sprite(black, minX, minY), new Sprite(this.overlay, obj.X, obj.Y),
				paths[obj.SubType], paths[obj.SubType + 1], new Sprite(white, minX, minY));

			overlay.Offset(-obj.X, -obj.Y);
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType > 2) return base.GetBounds(obj);

			return new Rectangle(obj.X - 64, obj.Y - 16, 128, 32);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType >> 1,
				(obj, value) => obj.SubType = (byte)((int)value << 1));

			startCoords = new Point[4];
			paths = new Sprite[4];
			BuildPathsCoords(0, 0x1390, 0x2D0, 0x1230, 0x2D0, 0x1230, 0x300);
			BuildPathsCoords(1, 0x13F0, 0x2D0, 0x1560, 0x2D0, 0x1560, 0x280);
			BuildPathsCoords(2, 0x2090, 0x650, 0x2030, 0x650, 0x2030, 0x680);
			BuildPathsCoords(3, 0x20F0, 0x650, 0x21E0, 0x650, 0x21E0, 0x600);

			var bitmap = new BitmapBits(129, 401);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 128, 32);
			bitmap.DrawLine(LevelData.ColorWhite, 64, 32, 64, 400);
			bitmap.DrawLine(LevelData.ColorBlack, 65, 32, 65, 400);
			overlay = new Sprite(bitmap, -64, -16);
		}

		private void BuildPathsCoords(int index, int startX, int startY, params int[] waypoints)
		{
			startCoords[index] = new Point(startX, startY);
			int minX = startX, maxX = startX, minY = startY, maxY = startY;

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				var curX = waypoints[i];
				if (curX < minX) minX = curX; else if (curX > maxX) maxX = curX;
				var curY = waypoints[i + 1];
				if (curY < minY) minY = curY; else if (curY > maxY) maxY = curY;
			}

			var bitmap = new BitmapBits(maxX - minX + 2, maxY - minY + 2);
			int x1 = startX - minX , y1 = startY - minY;
			var previous = new Point(x1, y1);

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				int x2 = waypoints[i] - minX, y2 = waypoints[i + 1] - minY;
				bitmap.DrawLine(LevelData.ColorBlack, x1, y1 + 1, x2, y2 + 1);
				bitmap.DrawLine(LevelData.ColorBlack, x1 + 1, y1, x2 + 1, y2);
				bitmap.DrawLine(LevelData.ColorBlack, x1 + 1, y1 + 1, x2 + 1, y2 + 1);
				x1 = x2; y1 = y2;
			}

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				var current = new Point(waypoints[i] - minX, waypoints[i + 1] - minY);
				bitmap.DrawLine(LevelData.ColorWhite, previous, current);
				previous = current;
			}

			previous.Offset(minX, minY);
			paths[index] = new Sprite(bitmap, minX, minY);
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

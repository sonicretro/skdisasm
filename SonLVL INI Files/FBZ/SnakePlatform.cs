using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class SnakePlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Point[][] coords;
		private Sprite[] paths;
		private Sprite overlay;

		public override string Name
		{
			get { return "Snake Blocks"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = obj.SubType & 0x0F;
			if (index >= coords.Length) return new Sprite();

			var points = coords[index];
			var sprites = new Sprite[points.Length];
			for (var i = 0; i < sprites.Length; i++)
				sprites[i] = new Sprite(this.sprite, points[i]);

			var sprite = new Sprite(sprites);
			sprite.Offset(-obj.X, -obj.Y);
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = obj.SubType & 0x0F;
			if (index >= paths.Length) return overlay;

			return new Sprite(new Sprite(paths[index], -obj.X, -obj.Y), overlay);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 13, obj.Y - 13, 26, 26);
		}

		public override void Init(ObjectData data)
		{
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Snake Platform.asm", LevelData.Game.MappingsVersion);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -7744);

			sprite = ObjectHelper.MapToBmp(indexer.ToArray(), map, 0, 1);
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];

			var bitmap = new BitmapBits(13, 13);
			bitmap.DrawCircle(LevelData.ColorWhite, 0, 0, 12);
			overlay = new Sprite(bitmap);

			overlay = new Sprite(overlay,
				new Sprite(overlay, false, true),
				new Sprite(overlay, true, false),
				new Sprite(overlay, true, true));

			paths = new Sprite[8];
			coords = new Point[8][];

			BuildPathsCoords(0, 0x118C, 0x770, false, 0x10F1, 0x770);
			BuildPathsCoords(1, 0x1174, 0x7F0, false, 0x120F, 0x7F0);
			BuildPathsCoords(2, 0xD64, 0x420, false, 0xC56, 0x510, 0xD64);
			BuildPathsCoords(3, 0xC1A, 0x317, false, 0xCE3, 0x3C8, 0xB64, 0x317);
			BuildPathsCoords(4, 0xC1B, 0x3C8, false, 0xB65, 0x317, 0xCE3, 0x3C8);
			BuildPathsCoords(5, 0xC56, 0x510, false, 0xD64, 0x420, 0xC56);
			BuildPathsCoords(6, 0x1EEB, 0x213, true, 0x400, 0x1D79, 0x319, 0x1E82, 0x369, 0x1E1E, 0x213);
			BuildPathsCoords(7, 0x1E82, 0x319, true, 0x369, 0x1E1E, 0x213, 0x1EEB, 0x400, 0x1D79, 0x319);

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
		}

		private void BuildPathsCoords(int index, int startX, int startY, bool startVertical, params int[] waypoints)
		{
			int minX = startX, minY = startY;
			int maxX = startX, maxY = startY;
			var curVertical = startVertical;

			foreach (var coord in waypoints)
			{
				if (curVertical)
				{
					if (coord < minY) minY = coord;
					else if (coord > maxY) maxY = coord;
				}
				else
				{
					if (coord < minX) minX = coord;
					else if (coord > maxX) maxX = coord;
				}

				curVertical = !curVertical;
			}

			var bitmap = new BitmapBits(maxX - minX + 1, maxY - minY + 1);
			int curX = startX - minX, curY = startY - minY;
			curVertical = startVertical;

			foreach (var coord in waypoints)
			{
				if (curVertical)
					bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX, curY = coord - minY);
				else
					bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX = coord - minX, curY);

				curVertical = !curVertical;
			}

			bitmap.DrawLine(LevelData.ColorWhite, curX, curY, startX - minX, startY - minY);
			paths[index] = new Sprite(bitmap, minX, minY);
			var points = new Point[4];

			if (curVertical)
			{
				var offset = curY > startY - minY ? 30 : -30;
				for (var i = 0; i < points.Length; i++)
					points[i] = new Point(startX, startY + i * offset);
			}
			else
			{
				var offset = curX > startX - minX ? 30 : -30;
				for (var i = 0; i < points.Length; i++)
					points[i] = new Point(startX + i * offset, startY);
			}

			coords[index] = points;
		}
	}
}

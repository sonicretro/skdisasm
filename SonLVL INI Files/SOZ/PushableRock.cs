using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class PushableRock : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private int[][] waypoints;

		public override string Name
		{
			get { return "Pushable Rock"; }
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
			return sprite[obj.YFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = obj.SubType & 0x1F;
			if (index >= waypoints.Length) return null;

			int minX = obj.X, minY = obj.Y;
			int maxX = obj.X, maxY = obj.Y;
			var curHorizontal = false;

			foreach (var coord in waypoints[index])
			{
				if (curHorizontal)
				{
					if (coord < minX) minX = coord;
					else if (coord > maxX) maxX = coord;
				}
				else if (coord != 0xD00)
				{
					if (coord < minY) minY = coord;
					else if (coord > maxY) maxY = coord;
				}
				else maxY += 47;

				curHorizontal = !curHorizontal;
			}

			var bitmap = new BitmapBits(maxX - minX + 1, maxY - minY + 1);
			int curX = obj.X - minX, curY = obj.Y - minY;
			curHorizontal = false;

			foreach (var coord in waypoints[index])
			{
				if (curHorizontal)
					bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX = coord - minX, curY);
				else if (coord <= maxY)
					bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX, curY = coord - minY);
				else
				{
					bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX, (curY += 20) - 5);

					for (var count = 0; count < 4; count++)
						bitmap.DrawLine(LevelData.ColorWhite, curX, curY, curX, (curY += 8) - 5);
				}

				curHorizontal = !curHorizontal;
			}

			return new Sprite(bitmap, minX - obj.X, minY - obj.Y);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var map = LevelData.ASMToBin(
				"../Levels/SOZ/Misc Object Data/Map - Pushable Rock.asm", LevelData.Game.MappingsVersion);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -4480);

			sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(indexer.ToArray(), map, 0, 2));
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[2];

			waypoints = new[]
			{
				new[] { 0xA68, 0x13A0, 0xD00 },
				new[] { 0xA70, 0x19C0, 0xAD2, 0x1AF0 },
				new[] { 0x470, 0x1F40, 0x490, 0x1FA0, 0xD00 },
				new[] { 0xAD0, 0x2D80, 0xB00, 0x2E30, 0xD00 },
				new[] { 0x450, 0x24C0, 0x4F0, 0x2560, 0xD00 },
				new[] { 0x270, 0x1600, 0x2D2, 0x1730 },
				new[] { 0xA68, 0x2740, 0xA80, 0x2838, 0xD00 },
				new[] { 0x5EC, 0x47F0 },
				new[] { 0x4E0, 0x4620, 0x600 },
				new[] { 0x630, 0x460, 0x652, 0x4F0 },
				new[] { 0x6F0, 0x2D70 }
			};

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x1F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xE0) | ((int)value & 0x1F)));

			properties[1] = new PropertySpec("End Puzzle", typeof(bool), "Extended",
				"If set, the rock will hold down switches with the same flag.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, false, true) };
		}
	 }
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class ChainedPlatforms : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Point[][] waypoints;
		private Point[][] coords;
		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Chained Platforms"; }
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
			if (obj.SubType < 0x80)
			{
				int path = obj.SubType >> 4, index = obj.SubType & 0x0F;

				if (path < waypoints.Length && index < waypoints[path].Length)
					return sprite[obj.YFlip ? 1 : 0];
			}
			else
			{
				var path = obj.SubType & 0x7F;

				if (path < coords.Length)
					return new Sprite(BuildSpawnerSprite(path));
			}

			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType < 0x80)
			{
				int path = obj.SubType >> 4, index = obj.SubType & 0x0F;

				if (path < waypoints.Length && index < waypoints[path].Length)
					return BuildPathOverlay((short)obj.X, (short)obj.Y, path, index);
			}
			else
			{
				var path = obj.SubType & 0x7F;

				if (path < coords.Length)
					return new Sprite(BuildSpawnerOverlay(path));
			}

			return null;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType < 0x80 || (obj.SubType & 0x7F) >= coords.Length)
				return base.GetBounds(obj);

			return new Rectangle(obj.X - 24, obj.Y - 24, 48, 48);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis),
				"../Levels/LRZ/Misc Object Data/Map - Chained Platforms.asm", 0, 1));

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			waypoints = new[]
			{
				BuildCoords(
					0, 0, 0xFFEA, 0xA, 0xFFE0, 0x20, 0xFFE0, 0xC0, 0xFFEA, 0xD6,
					0, 0xE0, 0x16, 0xD6, 0x20, 0xC0, 0x20, 0x20, 0x16, 0xA),
				BuildCoords(
					0, 0, 0xFFEA, 0xA, 0xFFE0, 0x20, 0xFFE0, 0x140, 0xFFEA, 0x156,
					0, 0x160, 0x16, 0x156, 0x20, 0x140, 0x20, 0x20, 0x16, 0xA),
				BuildCoords(
					0, 0, 0xFFEA, 0xA, 0xFFE0, 0x20, 0xFFE0, 0x1C0, 0xFFEA, 0x1D6,
					0, 0x1E0, 0x16, 0x1D6, 0x20, 0x1C0, 0x20, 0x20, 0x16, 0xA)
			};

			coords = new[]
			{
				BuildCoords(0, 0, 0xFFE0, 0x70, 0, 0xE0, 0x20, 0x70),
				BuildCoords(0, 0, 0xFFE0, 0xB0, 0, 0x160, 0x20, 0xB0),
				BuildCoords(
					0, 0, 0xFFE0, 0x72, 0xFFE0, 0xF0, 0xFFE0, 0x16E,
					0, 0x1E0, 0x20, 0x16E, 0x20, 0xF0, 0x20, 0x72)
			};

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType < 0x80 ? obj.SubType >> 4 : obj.SubType & 0x7F,
				(obj, value) => obj.SubType = (byte)(obj.SubType < 0x80
					? ((obj.SubType & 0x0F) | (((int)value << 4) & 0x70)) : (0x80 | (int)value)));

			properties[1] = new PropertySpec("Target", typeof(bool), "Extended",
				"The first waypoint associated with this object.", null, new Dictionary<string, int>
				{
					{ "Spawner", -1 }
				},
				(obj) => obj.SubType < 0x80 ? obj.SubType & 0x0F : -1,
				(obj, value) =>
				{
					var waypoint = (int)value;
					if (waypoint >= 0)
					{
						obj.SubType = (byte)((obj.SubType < 0x80
							? (obj.SubType & 0x70) : ((obj.SubType << 4) & 0x70)) | (waypoint & 0x0F));
					}
					else if (obj.SubType < 0x80)
					{
						obj.SubType = (byte)(0x80 | (obj.SubType >> 4));
					}
				});
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, false, true) };
		}

		private Point[] BuildCoords(params ushort[] values)
		{
			var coords = new Point[values.Length >> 1];

			for (int index = 0, offset = 0; index < coords.Length; index++)
				coords[index] = new Point((short)values[offset++], (short)values[offset++]);

			return coords;
		}

		private IEnumerable<Sprite> BuildSpawnerSprite(int path)
		{
			foreach (var point in coords[path])
				yield return new Sprite(sprite[0], point);
		}

		private IEnumerable<Sprite> BuildSpawnerOverlay(int path)
		{
			var waypoints = this.waypoints[path];
			var waypoint = waypoints[0];

			for (var index = waypoints.Length - 1; index >= 0; index--)
			{
				var overlay = BuildPathOverlay(waypoint.X, waypoint.Y, path, index);
				overlay.Offset(waypoint);
				waypoint = waypoints[index];

				yield return overlay;
			}
		}

		private Sprite BuildPathOverlay(int startX, int startY, int path, int index)
		{
			var waypoint = waypoints[path][index];
			var flipX = waypoint.X < startX;
			var flipY = waypoint.Y < startY;

			var width = flipX ? startX - waypoint.X : waypoint.X - startX;
			var height = flipY ? startY - waypoint.Y : waypoint.Y - startY;
			var bitmap = new BitmapBits(width + 1, height + 1);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, width, height);

			var overlay = new Sprite(bitmap, flipX ? -1 : 0, flipY ? -1 : 0);
			overlay.Flip(flipX, flipY);
			return overlay;
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class TunnelLauncher : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] unknownSprite;
		private Sprite[] paths;
		private Sprite image;

		public override string Name
		{
			get { return "Tunnel Launcher"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			return image;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = (obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0);

			var path = obj.SubType & 0x1F;
			if (path >= paths.Length)
				return unknownSprite[index];

			return new Sprite(sprite[index], new Sprite(paths[path], -obj.X, -obj.Y));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var path = obj.SubType & 0x1F;
			if (path >= paths.Length) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);
			return new Rectangle(obj.X - 24, obj.YFlip ? obj.Y - 16 : obj.Y, 48, 16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -1792);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/DEZ/Misc Object Data/Map - Tunnel Launcher.asm", version);
			var ringmap = LevelData.ASMToBin(
				"../Levels/DEZ/Misc Object Data/Map - Transporter Rings.asm", version);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			image = ObjectHelper.MapToBmp(art, map, 1, 0);
			var number = ObjectHelper.MapToBmp(art, map, 10, 0);
			sprite = new Sprite[4];
			number.Offset(56, -44);
			sprite[0] = new Sprite(image, number);
			number.Offset(-112, 0);
			sprite[1] = new Sprite(image, number);
			sprite[2] = new Sprite(sprite[1], true, true);
			sprite[3] = new Sprite(sprite[0], true, true);

			paths = new Sprite[16];
			paths[0] = ObjectHelper.MapToBmp(art, ringmap, 0, 1);
			paths[1] = ObjectHelper.MapToBmp(art, ringmap, 7, 1);
			paths[2] = ObjectHelper.MapToBmp(art, ringmap, 8, 1);
			paths[3] = ObjectHelper.MapToBmp(art, ringmap, 9, 1);
			paths[4] = ObjectHelper.MapToBmp(art, ringmap, 10, 1);
			paths[5] = ObjectHelper.MapToBmp(art, ringmap, 11, 1);
			paths[6] = ObjectHelper.MapToBmp(art, ringmap, 12, 1);
			paths[7] = ObjectHelper.MapToBmp(art, ringmap, 13, 1);
			paths[8] = paths[0];
			paths[9] = ObjectHelper.MapToBmp(art, ringmap, 1, 1);
			paths[10] = ObjectHelper.MapToBmp(art, ringmap, 2, 1);
			paths[11] = ObjectHelper.MapToBmp(art, ringmap, 3, 1);
			paths[12] = paths[11];
			paths[13] = paths[11];
			paths[14] = paths[10];
			paths[15] = paths[9];

			paths = new[]
			{
				BuildPath(
					0x1B80, 0x331, 0x1BD8, 0x328, 0x1C8C, 0x328, 0x8004, 0x400, 0x8108, 0x800, 0x80FC, 0x7C80,
					0x80FC, 0x7C40, 0x81F8, 0x3880, 0x8004, 0x480, 0x8108, 0x8840, 0x81F8, 0xB840, 0x8108, 0xC840,
					0x8004, 0x44C0, 0x8108, 0xC800, 0x81F8, 0x7880, 0x8004, 0x440, 0x80FC, 0xBC80, 0x8108, 0x800,
					0x81F8, 0x7840, 0x8004, 0xC400, 0x8108, 0x800, 0x8004, 0x840, 0x8108, 0x4840, 0x8004, 0x4480,
					0x81F8, 0xF880, 0x80FC, 0x7C00, 0x81F8, 0xF880, 0x202C, 0x1A8, 0x81F8, 0x7880, 0x20D4, 0x1A8),
				BuildPath(
					0x2B80, 0x3B1, 0x2BD8, 0x3A8, 0x2C78, 0x3A8, 0x8004, 0x4C0, 0x8108, 0xC8C0, 0x8004, 0xC400,
					0x81F8, 0x7840, 0x8108, 0xC800, 0x8004, 0x480, 0x81F8, 0xF800, 0x8108, 0x88C0, 0x8004, 0xC440,
					0x8108, 0x48C0, 0x8004, 0xC440, 0x81F8, 0xB840, 0x80FC, 0x3C80, 0x81F8, 0x7800, 0x80FC, 0xFC40,
					0x81F8, 0x38C0, 0x80FC, 0xBC40, 0x81F8, 0x38C0, 0x80FC, 0xBC40, 0x81F8, 0x38C0, 0x80FC, 0xBC40,
					0x81F8, 0x38C0, 0x80FC, 0xBC80, 0x3044, 0x268, 0x81F8, 0x7880, 0x80FC, 0x7CC0, 0x81F8, 0xB880,
					0x8108, 0x800, 0x8004, 0x440, 0x81F8, 0xB880, 0x80FC, 0x7CC0, 0x81F8, 0xB880, 0x3140, 0x228,
					0x81F8, 0x7880, 0x31D0, 0x228),
				BuildPath(
					0x1D00, 0x1B1, 0x1D54, 0x1A8, 0x1E08, 0x1A8, 0x8004, 0x400, 0x8108, 0x800, 0x81F8, 0x7880,
					0x81F8, 0x78C0, 0x80FC, 0xBC40, 0x8108, 0xC8C0, 0x8108, 0xC800, 0x1F44, 0x228, 0x81F8, 0x7840,
					0x8108, 0xC8C0, 0x81F8, 0x3880, 0x204C, 0x228),
				null,
				BuildPath(
					0x2B80, 0x5B1, 0x2BD8, 0x5A8, 0x2C80, 0x5A8, 0x8108, 0x800, 0x8004, 0x400, 0x2CC8, 0x5A8,
					0x80FC, 0x7C40, 0x8004, 0xC440, 0x8108, 0x4840, 0x8108, 0x4880, 0x80FC, 0xFC80, 0x81F8,
					0x7800, 0x8108, 0x8880, 0x8004, 0x8400, 0x2EBC, 0x668, 0x81F8, 0x7800, 0x80FC, 0xFC80,
					0x8108, 0x8C0, 0x8004, 0xC000, 0x2F08, 0x628, 0x2F44, 0x628),
				BuildPath(
					0x2F00, 0x8F1, 0x2EA8, 0x8E8, 0x2DF4, 0x8E8, 0x80FC, 0xFCC0, 0x81F8, 0xB880, 0x80FC, 0x7C00,
					0x80FC, 0xFC00, 0x8108, 0x8840, 0x8004, 0x4000, 0x8108, 0x880, 0x8004, 0x8480, 0x81F8, 0xF840,
					0x80FC, 0x40C0, 0x8108, 0x48C0, 0x81F8, 0x3840, 0x2C34, 0x9DC, 0x8004, 0xC440, 0x2D34, 0x9AC,
					0x8108, 0x4880, 0x81F8, 0xF800, 0x8108, 0x8880, 0x2C88, 0x96C, 0x80FC, 0xFC00, 0x81F8, 0xF8C0,
					0x8108, 0x48C0, 0x81F8, 0x3800, 0x2AB0, 0x968),
				BuildPath(
					0x2C00, 0x6B1, 0x2BA8, 0x6A8, 0x2AF4, 0x688, 0x8304, 0x8480, 0x8304, 0x8480, 0x2A40, 0x4E8),
				BuildPath(
					0x2500, 0x38E, 0x24A8, 0x398, 0x240C, 0x398, 0x8204, 0x8480, 0x8204, 0x8480, 0x8204, 0x8480,
					0x8204, 0x84C0, 0x8204, 0xC400, 0x24D8, 0x638)
			};

			paths[3] = paths[2];

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x1F,
				(obj, value) => obj.SubType = (byte)((int)value & 0x1F));
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite BuildPath(params ushort[] pathData)
		{
			var sprites = new LinkedList<Tuple<int, int, int>>();
			var routine = Routine.Setup;
			int spawnTimer = 7, index = 0;

			decimal xpos = pathData[index++], xvel = 0.0m;
			decimal ypos = pathData[index++], yvel = 0.0m;
			int xorigin = 0, yorigin = 0;
			byte angle = 0;

			while (true)
			{
				switch (routine)
				{
					case Routine.Done:
						var first = sprites.First.Value;
						int minX = first.Item1, maxX = first.Item1, minY = first.Item2, maxY = first.Item2;

						foreach (var s in sprites)
						{
							if (s.Item1 < minX) minX = s.Item1; else if (s.Item1 > maxX) maxX = s.Item1;
							if (s.Item2 < minY) minY = s.Item2; else if (s.Item2 > maxY) maxY = s.Item2;
						}

						var bitmap = new BitmapBits(maxX - minX + 49, maxY - minY + 49);
						foreach (var s in sprites)
							bitmap.DrawSprite(paths[s.Item3], s.Item1 - minX + 24, s.Item2 - minY + 24);

						return new Sprite(bitmap, minX - 24, minY - 24);

					case Routine.Line:
						if (--xorigin > 0)
						{
							xpos += xvel;
							ypos += yvel;
							break;
						}

						xpos = pathData[index++];
						ypos = pathData[index++];
						goto case Routine.CheckDone;

					case Routine.CheckDone:
						if (index == pathData.Length)
						{
							routine = Routine.Done;
							break;
						}

						if ((short)pathData[index] >= 0) goto case Routine.NextWaypoint;

						routine = ((pathData[index] >> 8) & 0x7F) + Routine.CircleLarge;
						spawnTimer = routine == Routine.CircleSmall ? 0 : 1;
						angle = (byte)(pathData[index + 1] >> 8);
						{
							var radians = Math.PI * ((angle + 0x20) & 0xC0) / 128.0;
							var scalefactor = routine == Routine.CircleSmall ? -64.0 : -128.0;
							xorigin = (int)decimal.Floor(xpos) + (int)(Math.Sin(radians) * scalefactor);

							if (routine == Routine.CircleLarge || routine == Routine.CircleSmall)
								yorigin = (int)decimal.Floor(ypos) + (int)(Math.Cos(radians) * scalefactor);
						}
						break;

					case Routine.CircleLarge:
					case Routine.CircleSmall:
						{
							var radians = Math.PI * angle / 128.0;
							var scalefactor = (5 - (int)routine) * 64.0;
							var sin = (int)(Math.Sin(radians) * scalefactor) + xorigin;
							var cos = (int)(Math.Cos(radians) * scalefactor) + yorigin;

							xvel = (sin - (int)decimal.Floor(xpos)) * 256;
							yvel = (cos - (int)decimal.Floor(ypos)) * 256;
							xpos = sin;
							ypos = cos;
						}
						goto case Routine.CheckAngle;

					case Routine.SineDown:
						yvel = 3.0m;
						goto case Routine.Sine;

					case Routine.SineUp:
						yvel = -3.0m;
						goto case Routine.Sine;

					case Routine.Sine:
						{
							var radians = Math.PI * angle / 128.0;
							var sin = (int)(Math.Sin(radians) * 128.0) + xorigin;

							xvel = (sin - (int)decimal.Floor(xpos)) * 256;
							xpos = sin;
							ypos += yvel;
						}
						goto case Routine.CheckAngle;

					case Routine.CheckAngle:
						if (angle == (byte)pathData[index + 1])
						{
							routine = Routine.Line;
							index += 2;
							goto case Routine.CheckDone;
						}

						angle += (byte)pathData[index];
						break;

					case Routine.Setup:
						routine = Routine.Line;
						goto case Routine.NextWaypoint;

					case Routine.NextWaypoint:
						var xoffset = pathData[index] - xpos;
						var yoffset = pathData[index + 1] - ypos;
						var xfactor = xoffset < 0 ? -xoffset : xoffset;
						var yfactor = yoffset < 0 ? -yoffset : yoffset;

						if (xfactor < yfactor)
						{
							yvel = yoffset < 0 ? -12.0m : 12.0m;
							yfactor = yoffset / yvel;
							xvel = xoffset == 0 ? 0 : (xoffset / yfactor);
							xorigin = (int)(yfactor < 0 ? -yfactor : yfactor) & 0xFF;
						}
						else
						{
							xvel = xoffset < 0 ? -12.0m : 12.0m;
							xfactor = xoffset / xvel;
							yvel = yoffset == 0 ? 0 : (yoffset / xfactor);
							xorigin = (int)(xfactor < 0 ? -xfactor : xfactor) & 0xFF;
						}
						break;
				}

				if (spawnTimer-- > 0) continue;
				spawnTimer = 1;

				var xoff = (int)decimal.Floor(xpos);
				var yoff = (int)decimal.Floor(ypos);
				var frame = routine == Routine.SineDown || routine == Routine.SineUp
					? (((angle - (byte)pathData[index] + 8) >> 4) & 7) + 8 : xvel == 0.0m ? 4
					: ((int)(Math.Atan((double)(yvel / xvel)) * 128.0 / Math.PI + 8) >> 4) & 7;

				sprites.AddFirst(new Tuple<int, int, int>(xoff, yoff, frame));
			}
		}

		private enum Routine
		{
			Done = 0,
			Setup = 1,
			Line = 2,
			CircleLarge = 3,
			CircleSmall = 4,
			SineDown = 5,
			SineUp = 6,
			Sine = 131,
			CheckAngle = 132,
			CheckDone = 133,
			NextWaypoint = 134
		}
	}
}

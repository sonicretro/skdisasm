using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class GiantRideVine : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite[] frames;
		private int[][][] spriteData;

		public override string Name
		{
			get { return "Swinging Vine"; }
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
			var angle = (obj.SubType & 0xF0) >> 4;
			var length = obj.SubType & 0x0F;

			return SpriteFromSpriteData(angle, length);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 8, obj.Y - 4, 16, 8);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/AIZ/Nemesis Art/Swing Vine.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/AIZ/Misc Object Data/Map - (&MHZ) Ride Vine.asm", version);

			frames = new Sprite[34];
			for (int frame = 0; frame < frames.Length; frame++)
				frames[frame] = ObjectHelper.MapToBmp(art, map, frame, 0);

			spriteData = new int[16][][];
			spriteData[5] = new[]
			{
				new int[] { 0, -15, -30, -46, -62, -78, -94, -109, -124, -137, -148, -159, -168, -174, -180, -187 },
				new int[] { 4, 10, 16, 19, 19, 20, 17, 11, 5, -4, -15, -26, -39, -54, -69, -86 },
				new int[] { 33, 6, 6, 7, 8, 8, 9, 10, 10, 11, 12, 12, 13, 14, 14, 15 }
			};
			spriteData[6] = new[]
			{
				new int[] { 0, -13, -28, -43, -59, -75, -91, -107, -122, -137, -150, -163, -174, -183, -192, -202 },
				new int[] { 4, 13, 19, 25, 28, 28, 29, 26, 20, 14, 5, -4, -15, -28, -41, -57 },
				new int[] { 33, 5, 6, 6, 7, 8, 8, 9, 10, 10, 11, 11, 12, 13, 13, 14 }
			};
			spriteData[7] = new[]
			{
				new int[] { 0, -11, -22, -35, -48, -63, -78, -94, -110, -126, -142, -158, -174, -189, -204, -221 },
				new int[] { 4, 15, 26, 35, 44, 50, 56, 59, 62, 62, 63, 60, 57, 51, 45, 35 },
				new int[] { 33, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11 }
			};
			spriteData[8] = new[]
			{
				new int[] { 0, -6, -12, -21, -30, -39, -48, -59, -70, -81, -92, -105, -118, -131, -144, -163 },
				new int[] { 4, 19, 34, 47, 60, 73, 86, 97, 108, 119, 130, 139, 148, 157, 166, 172 },
				new int[] { 33, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6 }
			};
			spriteData[9] = new[]
			{
				new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
				new int[] { 4, 20, 36, 52, 68, 84, 100, 116, 132, 148, 164, 180, 196, 212, 228, 244 },
				new int[] { 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			};
			spriteData[10] = new[]
			{
				new int[] { -1, 5, 11, 17, 26, 35, 44, 53, 64, 75, 86, 97, 110, 123, 136, 146 },
				new int[] { 4, 19, 34, 49, 62, 75, 88, 101, 112, 123, 134, 145, 154, 163, 172, 181 },
				new int[] { 33, 30, 30, 30, 29, 29, 29, 29, 28, 28, 28, 28, 27, 27, 27, 27 }
			};
			spriteData[11] = new[]
			{
				new int[] { -1, 10, 21, 34, 47, 62, 77, 93, 109, 125, 141, 157, 173, 188, 203, 213 },
				new int[] { 4, 15, 26, 35, 44, 50, 56, 59, 62, 62, 63, 60, 57, 51, 45, 35 },
				new int[] { 33, 28, 28, 27, 27, 26, 26, 25, 25, 24, 24, 23, 23, 22, 22, 21 }
			};
			spriteData[12] = new[]
			{
				new int[] { -1, 12, 27, 42, 58, 74, 90, 106, 121, 136, 149, 162, 173, 182, 191, 194 },
				new int[] { 4, 13, 19, 25, 28, 28, 29, 26, 20, 14, 5, -4, -15, -28, -41, -57 },
				new int[] { 33, 27, 26, 26, 25, 24, 24, 23, 22, 22, 21, 21, 20, 19, 19, 18 }
			};
			spriteData[13] = new[]
			{
				new int[] { -1, 12, 27, 43, 59, 75, 91, 106, 121, 134, 145, 156, 165, 171, 177, 177 },
				new int[] { 4, 13, 19, 22, 22, 23, 20, 14, 8, -1, -12, -23, -36, -51, -66, -83 },
				new int[] { 33, 27, 26, 25, 24, 24, 23, 22, 22, 21, 20, 20, 19, 18, 18, 17 }
			};

			spriteData[14] = spriteData[12];
			spriteData[15] = spriteData[11];
			spriteData[0] = spriteData[10];
			spriteData[1] = spriteData[9];
			spriteData[2] = spriteData[8];
			spriteData[3] = spriteData[7];
			spriteData[4] = spriteData[6];

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = SpriteFromSpriteData(0, 0);

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The number of rope segments in the object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (int)value & 0x0F));

			properties[1] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's movement cycle.", null,
				(obj) => (obj.SubType & 0xF0) >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | (((int)value << 4) & 0xF0)));
		}

		private Sprite SpriteFromSpriteData(int angle, int length)
		{
			var spriteData = this.spriteData[angle];
			var sprites = new Sprite[length + 2];

			sprites[0] = new Sprite(frames[32]);
			for (int dest = 0, src = length; src >= 0; src--)
			{
				sprites[dest++].Offset(spriteData[0][src], spriteData[1][src]);
				sprites[dest] = new Sprite(frames[spriteData[2][src]]);
			}

			return new Sprite(sprites);
		}
	}
}

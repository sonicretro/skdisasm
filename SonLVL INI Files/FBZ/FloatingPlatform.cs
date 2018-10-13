using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class FloatingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] unknownSprite;
		private int[] lengths;

		public override string Name
		{
			get { return "Floating Platform"; }
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
			var routine = obj.SubType & 0x70;
			var index = (obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0);

			if (routine > 0x40) return unknownSprite[index];
			var sprite = this.sprite[index];

			switch (routine)
			{
				case 0x10:
					return new Sprite(sprite, 0, obj.XFlip ? 32 : -32);
				case 0x20:
					return new Sprite(sprite, 0, obj.XFlip ? 64 : -64);
				case 0x30:
					var radians = Math.PI * (((4 - obj.SubType) & 0x0F) / 8.0);
					var xoffset = (int)(Math.Cos(radians) * 64.0);
					var yoffset = (int)(Math.Sin(radians) * 64.0);
					return new Sprite(sprite, xoffset, yoffset);
			}

			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x70;
			if (routine == 0x00 || routine > 0x40) return null;

			if (routine == 0x30)
			{
				var overlay = new BitmapBits(129, 129);
				overlay.DrawCircle(LevelData.ColorWhite, 64, 64, 64);
				return new Sprite(overlay, -64, -64);
			}
			else
			{
				var length = routine == 0x20 ? 128 : 64;
				var offset = -length / 2;

				if (routine == 0x40)
				{
					length = lengths[obj.SubType & 0x0F];
					offset = obj.XFlip ? -length : 0;
				}

				var overlay = new BitmapBits(1, length);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0, 0, length);
				return new Sprite(overlay, 0, offset);
			}
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -320);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/FBZ/Misc Object Data/Map - Floating Platform.asm", 0, 1));

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			lengths = new[] { 315, 324, 342, 361, 380, 390, 410, 420, 441, 451, 473, 484, 506, 517, 540, 552 };

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "None", 0x00 },
					{ "Vertical (64px)", 0x10 },
					{ "Vertical (128px)", 0x20 },
					{ "Circular (clockwise)", 0xB0 },
					{ "Circular (reverse)", 0x30 },
					{ "Player trigger", 0x40 }
				},
				(obj) =>
				{
					var routine = obj.SubType & 0x70;
					return obj.XFlip && routine == 0x30 ? 0xB0 : routine;
				},
				(obj, value) =>
				{
					var routine = ((int)value & 0x70);
					obj.SubType = (byte)((obj.SubType & 0x0F) | routine);
					if (routine == 0x30) obj.XFlip = ((int)value & 0x80) != 0;
				});

			properties[1] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point for the circular movement cycle.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
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

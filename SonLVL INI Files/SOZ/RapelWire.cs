using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class RapelWire : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Rappel Wire"; }
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

		public override byte DefaultSubtype
		{
			get { return 2; }
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
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var jumps = obj.SubType & 0x0F;
			if (jumps == 0 || (obj.SubType & 0x30) != 0) return null;

			var bitmap = new BitmapBits(64, 65);
			bitmap.DrawCircle(LevelData.ColorWhite, 65, 1, 63);
			bitmap.DrawLine(LevelData.ColorWhite, 63, 0x00, 63, 0x07);
			bitmap.DrawLine(LevelData.ColorWhite, 63, 0x10, 63, 0x17);
			bitmap.DrawLine(LevelData.ColorWhite, 63, 0x20, 63, 0x27);
			bitmap.DrawLine(LevelData.ColorWhite, 63, 0x30, 63, 0x37);

			var y = 142;
			var swings = obj.SubType >> 6;
			var width = swings == 0 ? 128 : swings * 512;
			var height = (swings == 0 ? 1 : swings) * jumps * 128 + y;

			var overlay = new Sprite(bitmap, -64, height - 64);
			bitmap = new BitmapBits(width, height + 1);
			bitmap.DrawLine(LevelData.ColorWhite, 12, 0, 12, y);

			if (swings == 0)
			{
				while (y != height)
					bitmap.DrawEllipse(LevelData.ColorWhite, -128, y, 127, y += 128);
			}
			else
			{
				var path = new BitmapBits(272, 65);
				path.DrawEllipse(LevelData.ColorWhite, -272, 0, 271, 96);
				var right = new Sprite(path);
				right = new Sprite(new Sprite(right, 512, 129, true, true), right);
				var left = new Sprite(right, true, false);

				var curLeft = false;
				for (var x = 0; y != height; y += 128)
				{
					bitmap.DrawSprite(curLeft ? left : right, x, y);
					curLeft = curLeft ? (x -= 512) != 0 : (x += 512) == width;
				}

				if (curLeft)
				{
					overlay.Flip(true, false);
					overlay.Offset(width, 0);
				}
			}

			overlay = new Sprite(new Sprite(bitmap), overlay);
			overlay.Offset(-12, 50);
			overlay.Flip(!obj.XFlip, false);
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/SOZ/Misc Object Data/Map - Rapel Wire.asm", version);
			var tiles = new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(tiles, -2304);
			indexer.AddFile(tiles, 63232);
			var art = indexer.ToArray();

			var rope = ObjectHelper.MapToBmp(art, map, 0, 2);
			var pulley = ObjectHelper.MapToBmp(art, map, 32, 3);
			sprite = ObjectHelper.MapToBmp(art, map, 33, 2);
			pulley.Flip(true, true);
			pulley.Offset(10, -16);

			for (var index = 0; index < 3; index++)
			{
				sprite.Offset(0, 16);
				sprite = new Sprite(sprite, rope);
			}

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(sprite, pulley);

			properties[0] = new PropertySpec("Jump Count", typeof(int), "Extended",
				"Times player must jump to reach the end of the wire.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) =>
				{
					var jumps = (int)value;
					obj.SubType = (byte)((obj.SubType & 0xC0) | (jumps < 1 ? 1 : jumps > 15 ? 15 : jumps));
				});

			properties[1] = new PropertySpec("Swing Count", typeof(int), "Extended",
				"Times player will swing in the air before changing direction", null,
				(obj) => obj.SubType >> 6,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | (((int)value << 6) & 0xC0)));
		}
	}
}

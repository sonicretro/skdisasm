using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class Door : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Door"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
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
			return sprites[0][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = obj.SubType > 0x0F ? 1 : 0;
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType > 0x0F)
			{
				var bitmap = new BitmapBits(128, 24);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 127, 23);
				return new Sprite(bitmap, obj.XFlip ? 64 : -192, -12);
			}
			else
			{
				var bitmap = new BitmapBits(24, 128);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 23, 127);
				return new Sprite(bitmap, -12, obj.XFlip ? 64 : -192);
			}
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var map = LevelData.ASMToBin(
				"../Levels/SOZ/Misc Object Data/Map - Door.asm", LevelData.Game.MappingsVersion);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -4480);
			var art = indexer.ToArray();

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 2)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 1, 2))
			};

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag monitored by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x00 },
					{ "Horizontal", 0x10 }
				},
				(obj) => obj.SubType > 0x0F ? 0x10 : 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | (int)value));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CNZ
{
	class HoverFan : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite invisibleSprite;

		public override string Name
		{
			get { return "Hover Fan"; }
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

		public override byte DefaultSubtype
		{
			get { return 0x80; }
		}

		public override string SubtypeName(byte subtype)
		{
			return null;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			var count = (subtype >> 4) & 7;
			return sprites[count > 3 ? 3 : count][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (obj.SubType < 0x80)
				return invisibleSprite;

			var count = (obj.SubType >> 4) & 7;
			return sprites[count > 3 ? 3 : count][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var count = (obj.SubType >> 4) & 7;
			var range = ((obj.SubType & 0x0F) + 4) << 4;

			var bitmap = new BitmapBits(17, range);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 16, 0);
			bitmap.DrawLine(LevelData.ColorWhite, 8, 0, 8, range);
			var overlay = new Sprite(bitmap, -8 - count * 16, -range);

			for (var index = 0; index < count; index++)
				overlay = new Sprite(new Sprite(overlay, 32, 0), overlay);

			if (obj.XFlip && obj.SubType >= 0x80)
			{
				bitmap = new BitmapBits(97, 1);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 96, 0);
				overlay = new Sprite(new Sprite(bitmap, -48, 0), overlay);
			}

			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = (obj.SubType >> 4) & 7;
			var width = (count + 1) * 32;
			return new Rectangle(obj.X - (width / 2), obj.Y - 8, width, 16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Animated Tiles/4.bin", CompressionType.Uncompressed)), 0);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), 2464);
			var map = LevelData.ASMToBin(
				"../Levels/CNZ/Misc Object Data/Map - Hover Fan.asm", LevelData.Game.MappingsVersion);
			var art = indexer.ToArray();

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[4][];

			invisibleSprite = new Sprite();

			for (var index = 0; index < sprites.Length; index++)
			{
				var offset = (map[index * 2] << 8) | map[(index * 2) + 1];
				var length = ((map[offset++] << 8) | map[offset++]) * 6 + offset;

				while (offset < length)
				{
					var pattern = ((map[offset + 2] << 8) | map[offset + 3]) + 228;
					map[offset + 2] = (byte)(pattern >> 8);
					map[offset + 3] = (byte)(pattern);
					offset = offset + 6;
				}

				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 2));
			}

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"The minimum height at which the player will float, in pixels.", null,
				(obj) => ((obj.SubType & 0x0F) + 8) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((((int)value >> 4) - 8) & 0x0F)));

			properties[1] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of fan blocks in the object.", null,
				(obj) => ((obj.SubType & 0x70) >> 4) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((((int)value - 1) << 4) & 0x70)));

			properties[2] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The object's movement and appearance.", null, new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Moving", 1 },
					{ "Invisible", 2 }
				},
				(obj) => obj.SubType < 0x80 ? 2 : obj.XFlip ? 1 : 0,
				(obj, value) =>
				{
					obj.XFlip = (int)value == 1;
					obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value == 2 ? 0 : 0x80)); 
				});
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

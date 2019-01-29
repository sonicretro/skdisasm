using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class SwingingCarrier : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Swinging Carrier"; }
		}

		public override Sprite Image
		{
			get { return sprites[0]; }
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
			return sprites[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var count = (obj.SubType & 3) + 5;
			if (count > 8) return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var sprite = new Sprite(sprites[0]);
			sprite.Offset(16, 0);

			for (var i = 0; i < count; i++)
			{
				sprite = new Sprite(sprites[1], sprite);
				sprite.Offset(16, 0);
			}

			var index = obj.SubType < 0x80 ? 2 : 3;
			sprite = new Sprite(sprites[index], sprite);
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var width = ((obj.SubType & 3) + 6) * 32;
			var radius = width / 2;
			var height = obj.SubType < 0x80 ? radius : width;

			var bitmap = new BitmapBits(width + 1, height + 1);
			bitmap.DrawCircle(LevelData.ColorWhite, radius, height - radius, radius);
			return new Sprite(bitmap, -radius, radius - height);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = (obj.SubType & 3) + 5;
			if (count > 8) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var bounds = sprites[0].Bounds;
			bounds.Offset(obj.X + ((count + 1) << 4), obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SSZ/Nemesis Art/Misc.bin", CompressionType.Nemesis)), -3712);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/SSZ/Misc Object Data/Map - Elevator Bar.asm", version);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 3, 3),
				ObjectHelper.MapToBmp(art, map, 2, 3),
				ObjectHelper.MapToBmp(art, map, 1, 2),
				ObjectHelper.MapToBmp(art, map, 4, 2)
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of segments in the object.", null,
				(obj) => (obj.SubType & 3) + 5,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value - 5) & 3)));

			properties[1] = new PropertySpec("Loop", typeof(bool), "Extended",
				"If set, the object will swing around at a constant speed.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 3) | ((bool)value ? 0x80 : 0)));

			properties[2] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will move counterclockwise.", null,
				(obj) => obj.XFlip,
				(obj, value) => obj.XFlip = (bool)value);
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

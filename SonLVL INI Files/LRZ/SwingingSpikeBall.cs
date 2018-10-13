using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class SwingingSpikeBall2 : SwingingSpikeBall
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", 2);
		}
	}

	class SwingingSpikeBall : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Swinging Spike Ball"; }
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
			var count = obj.SubType & 0x0F;
			if (count > 8) return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var sprite = new Sprite(sprites[0]);

			for (var index = 0; index <= count; index++)
			{
				sprite.Offset(16, 0);
				sprite = new Sprite(sprites[1], sprite);
			}

			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return null;

			var radius = (count + 1) * 16;
			var bitmap = new BitmapBits(radius * 2 + 1, radius * 2 + 1);
			bitmap.DrawCircle(LevelData.ColorWhite, radius, radius, radius);
			return new Sprite(bitmap, -radius, -radius);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var bounds = sprites[0].Bounds;
			bounds.Offset(obj.X + ((count + 1) << 4), obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Misc Art.bin", 0);
		}

		protected void BuildSpritesProperties(string artfile, int frame)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Swinging Spike Ball.asm", version);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, frame++, 1, true),
				ObjectHelper.MapToBmp(art, map, frame++, 0, true)
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of segments in the object.", null,
				(obj) => (obj.SubType & 0x0F) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value - 1) & 0x0F)));

			properties[1] = new PropertySpec("Speed Up", typeof(bool), "Extended",
				"If set, the object will rotate twice as fast.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((bool)value ? 0x80 : 0)));

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

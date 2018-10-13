using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.ICZ
{
	class SwingingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite image;

		public override string Name
		{
			get { return "Swinging Platform"; }
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
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bitmap = new BitmapBits(129, obj.SubType == 0 ? 240 : 148);
			bitmap.DrawCircle(LevelData.ColorWhite, 0, 128, 128);

			var overlay = new Sprite(bitmap);
			overlay.Flip(obj.XFlip, true);
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 32, obj.Y - 16, 64, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../Levels/ICZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/ICZ/Misc Object Data/Map - Platforms.asm", version);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			image = ObjectHelper.MapToBmp(art, map, 7, 1);

			var ring = ObjectHelper.MapToBmp(art, map, 8, 2);
			var sprite = new Sprite(ring, 0, -16);
			for (var index = 0; index < 7; index++)
			{
				sprite = new Sprite(sprite, ring);
				sprite.Offset(0, -16);
			}

			sprite = new Sprite(sprite, image);
			var flipped = new Sprite(sprite, new Sprite(image, false, true));

			this.sprite = new[]
			{
				sprite, new Sprite(sprite, true, false),
				flipped, new Sprite(flipped, true, false)
			};

			properties[0] = new PropertySpec("Collapsing", typeof(bool), "Extended",
				"If set, the platform will break off at the apex of its swing.", null,
				(obj) => obj.SubType != 0,
				(obj, value) => obj.SubType = (byte)((bool)value ? 2 : 0));
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

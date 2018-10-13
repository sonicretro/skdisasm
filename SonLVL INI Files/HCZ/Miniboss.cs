using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class Miniboss : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite extraSprite;
		private Sprite image;

		public override string Name
		{
			get { return "Miniboss"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			var sprite = GetFlippedSprite(obj);
			return new Sprite(extraSprite, sprite);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = GetFlippedSprite(obj).Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/HCZ/Nemesis Art/Miniboss.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/HCZ/Misc Object Data/Map - Miniboss.asm", version);

			image = ObjectHelper.MapToBmp(art, map, 0, 5, true);
			var rock1 = ObjectHelper.MapToBmp(art, map, 1, 5, true);
			var rock2 = new Sprite(rock1, 24, 24);
			rock1.Offset(-24, 24);
			var rock3 = ObjectHelper.MapToBmp(art, map, 9, 5, true);
			var rock4 = new Sprite(rock3, -24, -24);
			rock3.Offset(24, -24);
			var fire = ObjectHelper.MapToBmp(art, map, 21, 0, true);
			fire.Offset(0, 36);

			extraSprite = ObjectHelper.MapToBmp(art, map, 22, 5, true);
			extraSprite.Offset(0, 328);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(new Sprite(image, rock1, rock2, rock3, rock4, fire));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite GetFlippedSprite(ObjectEntry obj)
		{
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}
	}
}

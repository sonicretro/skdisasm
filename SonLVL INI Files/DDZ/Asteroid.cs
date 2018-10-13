using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DDZ
{
	class Asteroid : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Asteroid"; }
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
			get { return 2; }
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
			var sprite = unknownSprite;

			var index = obj.SubType >> 4;
			if (index < sprites.Length && (obj.SubType & 0x0F) < 6)
				sprite = sprites[index];

			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 0;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../Levels/DDZ/KosinskiM Art/Misc Art.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin(
				"../Levels/DDZ/Misc Object Data/Map - Missile Asteroid.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 38, 1, true)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 39, 1, true)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 40, 1, true))
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Scroll Rate", typeof(int), "Extended",
				"The object's scrolling speed relative to the camera.", null, new Dictionary<string, int>
				{
					{ "-10%" , 4 },
					{ "-5%", 3 },
					{ "Same rate", 2 },
					{ "+5%", 1 },
					{ "+10%", 0 },
					{ "+20%", 5 }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Sprite", typeof(int), "Extended",
				"The object's appearance and collision size.", null, new Dictionary<string, int>
				{
					{ "Small", 0 },
					{ "Medium", 1 },
					{ "Large", 2 }
				},
				(obj) => obj.SubType >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((int)value << 4)));
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

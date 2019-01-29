using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class ChainLink : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;
		private Sprite emptySprite;

		public override string Name
		{
			get { return "Chain Link"; }
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
			if (obj.SubType >= 0x80) return emptySprite;

			var length = obj.SubType;
			if (length == 0) return sprites[0];

			var index = length / 2 + 1;
			if (index < sprites.Length)
				return new Sprite(sprites[index], 0, length << 3);

			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType < 0x80) return null;

			var width = (obj.SubType & 0x3F) << 5;
			var bitmap = new BitmapBits(width, 40);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, width - 1, 39);

			var sprite = unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			return new Sprite(sprite, new Sprite(bitmap, -width / 2, -32));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType >= 0x80)
			{
				var width = (obj.SubType & 0x3F) << 5;
				return new Rectangle(obj.X - width / 2, obj.Y - 32, width, 40);
			}

			var length = obj.SubType;
			var index = length / 2 + 1;

			if (index < sprites.Length)
				return new Rectangle(obj.X - 8, obj.Y + (length << 3) + 96, 16, 40);

			return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/FBZ/Misc Object Data/Map - Chain Link.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[15];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 2);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			emptySprite = new Sprite();

			properties[0] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The object's orientation and behavior type.", null, new Dictionary<string, int>
				{
					{ "Descending", 0x00 },
					{ "Array", 0x80 },
					{ "Array (fall off last)", 0xC0 }
				},
				(obj) => obj.SubType < 0x80 ? 0 : obj.SubType & 0xC0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x3F) | ((int)value & 0xC0)));

			properties[1] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of chain links in the object.", null,
				(obj) => obj.SubType & 0x3F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xC0) | ((int)value & 0x3F)));
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

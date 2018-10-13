using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class LightSwitch : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Light Switch"; }
		}

		public override Sprite Image
		{
			get { return sprites[7]; }
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
			return sprites[7];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var length = obj.SubType & 0x7F;
			if (length < 6)
				return new Sprite(new Sprite(sprites[length], 0, length << 3), sprites[6]);

			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var length = obj.SubType & 0x7F;
			if (length < 6)
				return new Rectangle(obj.X - 24, obj.Y + (length << 3) + 8, 48, 24);

			return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/SOZ/Nemesis Art/Act 2 Extra Art.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/SOZ/Misc Object Data/Map - Light Switch.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 0);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of chain links in the object.", null,
				(obj) => obj.SubType & 0x7F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | ((int)value & 0x7F)));

			properties[1] = new PropertySpec("Floor Check", typeof(bool), "Extended",
				"If set, players will fall off the switch if they touch the floor.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
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

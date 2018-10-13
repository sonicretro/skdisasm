using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class BreakableBar : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Breakable Bar"; }
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
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/HCZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/HCZ/Misc Object Data/Map - Breakable Bar.asm", version);
			var unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties = new PropertySpec[4];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 2));

			sprites[3] = unknownSprite;
			sprites[7] = unknownSprite;

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The object's appearance and collision size.", null, new Dictionary<string, int>
				{
					{ "Short", 0 },
					{ "Medium", 1 },
					{ "Long", 2 }
				},
				(obj) => (obj.SubType & 0x30) >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xCF) | (((int)value << 4) & 0x30)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x00 },
					{ "Horizontal", 0x80 }
				},
				(obj) => obj.SubType & 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80)));

			properties[2] = new PropertySpec("Delay", typeof(int), "Extended",
				"How long the object will hold before breaking, in seconds.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[3] = new PropertySpec("Permanent", typeof(bool), "Extended",
				"If set, the object will not break when it is released.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[((subtype & 0x80) >> 5) | ((subtype & 0x30) >> 4)];
		}
	}
}

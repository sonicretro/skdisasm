using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.ICZ
{
	class CorkFloor : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private IDictionary<byte, string> subtypeNames;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Cork Floor"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			var index = GetSpriteIndex(subtype);
			return sprites[index][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = GetSpriteIndex(obj.SubType);
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/ICZ/Misc Object Data/Map - Cork Floor.asm", LevelData.Game.MappingsVersion);

			subtypeNames = new Dictionary<byte, string>
			{
				{ 0x00, "Loop x5" },
				{ 0x02, "Loop x4" },
				{ 0x04, "Loop x3" },
				{ 0x06, "Loop x2" },
				{ 0x08, "Loop x1" },
				{ 0x1A, "Square" }
			};

			subtypes = new ReadOnlyCollection<byte>(new List<byte>(subtypeNames.Keys));
			sprites = new Sprite[8][];

			for (var index = 0; index < 5; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index * 2, 2));

			sprites[5] = BuildFlippedSprites(ObjectHelper.MapToBmp(LevelData.ReadFile(
				"../Levels/ICZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis), map, 10, 2));
			sprites[6] = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprites[7] = sprites[6];
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private int GetSpriteIndex(byte subtype)
		{
			var offset = subtype & 0x1F;
			if (offset == 0x1A) return 5;
			return (offset & 1) == 1 || offset > 8 ? 7 : offset >> 1;
		}
	}
}

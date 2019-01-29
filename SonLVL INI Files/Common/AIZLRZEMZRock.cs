using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class Rock : Common.AIZLRZEMZRock
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/AIZ/Nemesis Art/Misc Art 1.bin",
				"../Levels/AIZ/Misc Object Data/Map - Rock.asm", 0, 1, 0x04,
				new Dictionary<string, int>
				{
					{ "Large", 0 },
					{ "Medium", 1 },
					{ "Small", 2 }
				});
		}
	}

	class Rock2 : Common.AIZLRZEMZRock
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/AIZ/Nemesis Art/Misc Art 2.bin",
				"../Levels/AIZ/Misc Object Data/Map - Rock 2.asm", 0, 2, 0x04,
				new Dictionary<string, int>
				{
					{ "Large", 0 },
					{ "Medium", 1 },
					{ "Small", 2 }
				});
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class Rock : Common.AIZLRZEMZRock
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -6752);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/LRZ/Misc Object Data/Map - Breakable Rock.asm", 4, 2, 0x44,
				new Dictionary<string, int>
				{
					{ "Vertical", 4 },
					{ "Horizontal", 5 },
					{ "Horizontal 2", 6 }
				});
		}
	}

	class Rock2 : Common.AIZLRZEMZRock
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin",
				"../Levels/LRZ/Misc Object Data/Map - Breakable Rock 2.asm", 4, 3, 0x74,
				new Dictionary<string, int>
				{
					{ "Vertical", 7 },
					{ "Horizontal", 6 }
				});
		}
	}
}

namespace S3KObjectDefinitions.EMZ
{
	class Rock : Common.AIZLRZEMZRock
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/EMZ/Nemesis Art/Misc Art.bin",
				"../Levels/EMZ/Misc Object Data/Map - Rock.asm", -3, 3, 0x31,
				new Dictionary<string, int>
				{
					{ "Square", 3 }
				});

			foreach (var sprite in sprites[3]) sprite.InvertPriority();
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class AIZLRZEMZRock : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[][] sprites;

		private byte defaultSubtype;
		private Sprite defaultSprite;

		public override string Name
		{
			get { return "Breakable Rock"; }
		}

		public override Sprite Image
		{
			get { return defaultSprite; }
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
			get { return defaultSubtype; }
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

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var behavior = obj.SubType & 0x8F;
			if (behavior != 2 && behavior != 3) return null;

			var bitmap = new BitmapBits(65, 1);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 64, 0);
			return new Sprite(bitmap, -64, 0);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		protected void BuildSpritesProperties(string artfile, string mapfile,
			int startframe, int startpal, byte defaultSubtype, Dictionary<string, int> frames)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);
			BuildSpritesProperties(art, mapfile, startframe, startpal, defaultSubtype, frames);
		}

		protected void BuildSpritesProperties(byte[] art, string mapfile,
			int startframe, int startpal, byte defaultSubtype, Dictionary<string, int> frames)
		{
			var map = LevelData.ASMToBin(mapfile, LevelData.Game.MappingsVersion);
			var unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = unknownSprite;
			foreach (var frame in frames.Values)
				sprites[frame] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, frame + startframe, startpal));

			this.defaultSubtype = defaultSubtype;
			defaultSprite = SubtypeImage(defaultSubtype);

			properties[0] = new PropertySpec("Sprite", typeof(int), "Extended",
				"The object's appearance and collision size.", null, frames,
				(obj) => (obj.SubType & 0x70) >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | (((int)value << 4) & 0x70)));

			properties[1] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The direction from which the object can be broken.", null, new Dictionary<string, int>
				{
					{ "Solid", 0 },
					{ "Solid (pushable)", 2 },
					{ "Top", 1 },
					{ "Top (pushable)", 3 },
					{ "Top (Knuckles only)", 0xF },
					{ "Sides", 4 },
					{ "Sides (Knuckles only)", 0x84 },
					{ "Bottom", 8 }
				},
				(obj) => obj.SubType & 0x8F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x70) | ((int)value & 0x8F)));
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
			return sprites[(subtype & 0x70) >> 4];
		}
	}
}

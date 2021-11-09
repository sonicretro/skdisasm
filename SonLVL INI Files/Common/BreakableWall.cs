using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/AIZ/Misc Object Data/Map - Breakable Wall.asm", 2,
				new string[] { "Normal" },
				new Func<int, bool>[] { subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => (subtype & 0x0F) },
				new Dictionary<string, int>
				{
					{ "Pattern 1", 0 },
					{ "Pattern 2", 1 },
					{ "Pattern 3", 2 }
				});
		}
	}
}

namespace S3KObjectDefinitions.HCZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/HCZ/Misc Object Data/Map - Breakable Wall.asm", 3,
				new string[] { "Normal", "Knuckles only" },
				new Func<int, bool>[] { subtype => (subtype & 0x0F) != 2, subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => {subtype &= 0x0F; return subtype != 2 ? subtype : 0; }, subtype => 0x02 },
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});
		}
	}

	class BreakableWall2 : BreakableWall
	{
		public override void Init(ObjectData data)
		{
			base.Init(data);
			var art = LevelData.ReadFile("../Levels/HCZ/Nemesis Art/Act 2 Knuckles Wall.bin", CompressionType.Nemesis);
			var sprite = ObjectHelper.MapASMToBmp(art, "../Levels/HCZ/Misc Object Data/Map - Breakable Wall.asm", 2, 2);
			sprites[1] = BuildFlippedSprites(sprite);
			properties[0].Enumeration.Add("Knuckles Wall", 1);
		}
	}
}

namespace S3KObjectDefinitions.MGZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/MGZ/Misc Object Data/Map - Breakable Wall.asm", 2,
				new string[] { "Normal", "Spinner only", "Knuckles only" },
				new Func<int, bool>[] { s => (s & 0x0F) != 2, s => (s & 0x10) == 0, s => (s & 0x80) == 0 || (s & 0x1F) == 2 },
				new Func<byte, int>[] { s => {s &= 0x0F; return s != 2 ? s : 0; }, s => 0x02, s => (s & 0x0F) | 0x10 },
				new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Spinner Wall", 1 }
				});
		}
	}
}

namespace S3KObjectDefinitions.CNZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -6624);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/CNZ/Misc Object Data/Map - (&SOZ) Breakable Wall.asm", 2,
				new string[] { "Normal", "Knuckles only" },
				new Func<int, bool>[] { subtype => (subtype & 0x0F) != 2, subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => {subtype &= 0x0F; return subtype != 2 ? subtype : 0; }, subtype => 0x02 },
				new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Knuckles Wall", 1 }
				});
		}
	}
}

namespace S3KObjectDefinitions.LBZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LBZ/Nemesis Art/Act 2 Misc Art.bin",
				"../Levels/LBZ/Misc Object Data/Map - Breakable Wall.asm", 1,
				new string[] { "Knuckles only" },
				new Func<int, bool>[] { subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => (subtype & 0x0F) },
				new Dictionary<string, int>
				{
					{ "Knuckles Wall", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.MHZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/MHZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -128);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/MHZ/Misc Object Data/Map - Breakable Wall.asm", 2,
				new string[] { "Knuckles only" },
				new Func<int, bool>[] { subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => (subtype & 0x0F) },
				new Dictionary<string, int>
				{
					{ "Knuckles Wall", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.SOZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -6240);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/CNZ/Misc Object Data/Map - (&SOZ) Breakable Wall.asm", 2,
				new string[] { "Knuckles only" },
				new Func<int, bool>[] { subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => (subtype & 0x0F) },
				new Dictionary<string, int>
				{
					{ "Knuckles Wall", 0 },
					{ "Knuckles Wall (large)", 2 }
				});
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class BreakableWall : Common.BreakableWall
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin",
				"../Levels/LRZ/Misc Object Data/Map - Breakable Wall.asm", 2,
				new string[] { "Normal" },
				new Func<int, bool>[] { subtype => (subtype & 0x80) == 0 },
				new Func<byte, int>[] { subtype => (subtype & 0x0F) },
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class BreakableWall : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[][] sprites;

		public override string Name
		{
			get { return "Breakable Wall"; }
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
			return 5;
		}

		protected void BuildSpritesProperties(string artfile, string mapfile, int startpal,
			string[] behaviors, Func<int, bool>[] getters, Func<byte, int>[] setters, Dictionary<string, int> frames)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);
			BuildSpritesProperties(art, mapfile, startpal, behaviors, getters, setters, frames);
		}

		protected void BuildSpritesProperties(byte[] art, string mapfile, int startpal,
			string[] behaviors, Func<int, bool>[] getters, Func<byte, int>[] setters, Dictionary<string, int> frames)
		{
			var map = LevelData.ASMToBin(mapfile, LevelData.Game.MappingsVersion);
			var unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = unknownSprite;
			foreach (var frame in frames.Values)
				sprites[frame] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, frame * 2, startpal));

			var options = new Dictionary<string, int>();
			for (var index = 0; index < behaviors.Length; index++)
				options.Add(behaviors[index], index);

			options.Add("Level trigger", behaviors.Length);

			properties[0] = new PropertySpec("Sprite", typeof(int), "Extended",
				"The object's appearance and collision size.", null, frames,
				(obj) => (obj.SubType & 0x0E) >> 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value << 1) & 0x0E)));

			properties[1] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The method through which the object can be destroyed.", null, options,
				(obj) =>
				{
					var index = getters.Length;

					while(index > 0 && getters[index - 1](obj.SubType))
						index--;

					return index;
				},
				(obj, value) =>
				{
					var index = (int)value;

					if (index == setters.Length)
						obj.SubType = (byte)(obj.SubType | 0x80);
					if (index >= 0 && index < setters.Length)
						obj.SubType = (byte)setters[index](obj.SubType);
				});
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[(subtype & 0x0E) >> 1];
		}
	}
}

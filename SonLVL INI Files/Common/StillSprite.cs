using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class StillSprite2 : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art1 = LevelData.ReadFile(
				"../Levels/AIZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art2 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 0, 2, false, 6, "Bridge Post"),
				new StillSpriteData(art1, 1, 2, false, 6, "Large Rope Twist Tie"),
				new StillSpriteData(art1, 2, 2, false, 6, "Rope Twist Tie"),
				new StillSpriteData(art2, 3, 2, false, 6, "Tie Top Sprite"),
				new StillSpriteData(art2, 4, 3, false, 6, "Waterfall Sprite"),
				new StillSpriteData(art1, 5, 2, true, 6, "Bridge Post (high priority)"));
		}
	}

	class AnimatedStillSprite2 : Common.AnimatedStillSprite
	{
		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../Levels/AIZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis);

			BuildSpritesSubtypes(
				new AnimatedStillSpriteData(0, art, 0, 3, false, 6, "Short Ember"),
				new AnimatedStillSpriteData(1, art, 5, 3, false, 6, "Tall Ember"));
		}
	}
}

namespace S3KObjectDefinitions.HCZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art, 6, 2, true, 0, "128x128 Waterfall"),
				new StillSpriteData(art, 7, 2, true, 0, "128x64 Waterfall"),
				new StillSpriteData(art, 8, 2, false, 6, "128x32 Waterfall"),
				new StillSpriteData(art, 9, 2, true, 0, "Stagger Down Waterfall"),
				new StillSpriteData(art, 10, 2, true, 0, "Stagger Up Waterfall"));
		}
	}

	class StillSprite2 : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art1 = indexer.ToArray();

			var bytes = new List<byte>(LevelData.ReadFile(
				"../Levels/HCZ/Nemesis Art/Act 2 Slide.bin", CompressionType.Nemesis));

			indexer.AddFile(bytes, -384);
			var art2 = indexer.ToArray();
			indexer.AddFile(bytes, -928);
			var art3 = indexer.ToArray();
			indexer.AddFile(bytes, -1952);
			var art4 = indexer.ToArray();
			indexer.AddFile(bytes, -2304);
			var art5 = indexer.ToArray();

			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/HCZ/Nemesis Art/Act 2 Block Platform.bin", CompressionType.Nemesis)), -512);
			var art6 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 6, 2, true, 0, "128x128 Waterfall"),
				new StillSpriteData(art1, 7, 2, true, 0, "128x64 Waterfall"),
				new StillSpriteData(art1, 8, 2, false, 6, "128x32 Waterfall"),
				new StillSpriteData(art1, 9, 2, true, 0, "Stagger Down Waterfall"),
				new StillSpriteData(art1, 10, 2, true, 0, "Stagger Up Waterfall"),
				new StillSpriteData(art2, 15, 2, true, 0, "Tube Bend 1"),
				new StillSpriteData(art3, 16, 2, true, 0, "Tube Bend 2"),
				new StillSpriteData(art4, 17, 2, true, 0, "Tube Bend 3"),
				new StillSpriteData(art5, 18, 2, true, 0, "Tube Crossover"),
				new StillSpriteData(art6, 19, 2, false, 6, "Bridge Post"));
		}
	}
}

namespace S3KObjectDefinitions.MGZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../Levels/MGZ/Nemesis Art/Direction Signs.bin", CompressionType.Nemesis);

			BuildSpritesSubtypes(
				new StillSpriteData(art, 11, 2, false, 6, "Signpost Left"),
				new StillSpriteData(art, 12, 2, false, 6, "Signpost Right"),
				new StillSpriteData(art, 13, 2, false, 6, "Signpost Up"),
				new StillSpriteData(art, 14, 2, false, 6, "Signpost Down"));
		}
	}
}

namespace S3KObjectDefinitions.FBZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art1 = LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(art1), -6464);
			var art2 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 39, 2, false, 1, "Metal Hanger"),
				new StillSpriteData(art1, 40, 2, false, 1, "Two Metal Hangers"),
				new StillSpriteData(art1, 41, 2, false, 1, "Three Metal Hangers"),
				new StillSpriteData(art1, 42, 2, false, 1, "Four Metal Hangers"),
				new StillSpriteData(art2, 43, 1, false, 6, "Unknown (unused)"));
		}
	}

	class StillSprite2 : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art1 = LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(art1), -6464);
			var art2 = indexer.ToArray();

			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis)), -3296);
			var art3 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 39, 2, false, 1, "Metal Hanger"),
				new StillSpriteData(art1, 40, 2, false, 1, "Two Metal Hangers"),
				new StillSpriteData(art1, 41, 2, false, 1, "Three Metal Hangers"),
				new StillSpriteData(art1, 42, 2, false, 1, "Four Metal Hangers"),
				new StillSpriteData(art2, 43, 1, false, 6, "Unknown (unused)"),
				new StillSpriteData(art3, 44, 1, false, 0, "Spider Rail"),
				new StillSpriteData(art3, 45, 1, false, 5, "Spider Rail (low priority)"));
		}
	}
}

namespace S3KObjectDefinitions.LBZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var bytes = new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(bytes, -2368);
			var art1 = indexer.ToArray();
			indexer.AddFile(bytes, -3584);
			var art2 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 20, 2, false, 6, "Cup Elevator Pole Top"),
				new StillSpriteData(art2, 21, 1, false, 6, "Steel Girder"),
				new StillSpriteData(art2, 22, 1, false, 6, "Steel Girder (large)"),
				new StillSpriteData(art2, 23, 1, false, 1, "Steel Girder (high priority)"));
		}
	}
}

namespace S3KObjectDefinitions.MHZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art4 = LevelData.ReadFile(
				"../Levels/MHZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis);

			var indexer = new MultiFileIndexer<byte>();
			var bytes = new List<byte>(art4);
			indexer.AddFile(bytes, -512);
			var art1 = indexer.ToArray();
			indexer.AddFile(bytes, -6368);
			var art2 = indexer.ToArray();
			indexer.AddFile(bytes, -6880);
			var art3 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 24, 2, true, 1, "Cliff Edge 1"),
				new StillSpriteData(art1, 25, 2, true, 1, "Cliff Edge 2"),
				new StillSpriteData(art1, 26, 2, true, 1, "Grass"),
				new StillSpriteData(art2, 27, 3, true, 1, "Wood Column Bottom"),
				new StillSpriteData(art2, 28, 3, true, 1, "Wood Column Top"),
				new StillSpriteData(art3, 29, 2, false, 4, "Parachute Vines"),
				new StillSpriteData(art4, 30, 0, false, 5, "Diagonal Spring Pedestal"));
		}
	}
}

namespace S3KObjectDefinitions.SOZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art, 46, 2, true, 2, "Indoor Sloped Edge"));
		}
	}

	class StillSprite2 : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var art1 = indexer.ToArray();

			var art2 = LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Act 2 Extra Art.bin", CompressionType.Nemesis);

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 46, 2, true, 2, "Indoor Sloped Edge"),
				new StillSpriteData(art2, 47, 0, false, 0, "Sand Cork Holder"));
		}
	}

	class AnimatedStillSprite : Common.AnimatedStillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -2240);
			var art = indexer.ToArray();

			BuildSpritesSubtypes(
				new AnimatedStillSpriteData(4, art, 14, 2, false, 6, "Pulley"),
				new AnimatedStillSpriteData(5, art, 18, 2, false, 6, "Two Pulleys"),
				new AnimatedStillSpriteData(6, art, 22, 2, false, 6, "Four Pulleys"),
				new AnimatedStillSpriteData(7, art, 26, 2, false, 6, "Six Pulleys"));
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var art1 = LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -6752);
			var art2 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 31, 2, true, 3, "Horizontal Gear Rail Small (unused)"),
				new StillSpriteData(art1, 32, 2, true, 3, "Horizontal Gear Rail Medium (unused)"),
				new StillSpriteData(art1, 33, 2, true, 3, "Horizontal Gear Rail Large (unused)"),
				new StillSpriteData(art2, 34, 2, true, 1, "Foreground Rock Ceiling"),
				new StillSpriteData(art1, 35, 1, true, 3, "Gear Rail Top"),
				new StillSpriteData(art1, 36, 1, true, 3, "Gear Rail Small"),
				new StillSpriteData(art1, 37, 1, true, 3, "Gear Rail Large"),
				new StillSpriteData(art1, 38, 1, true, 3, "Gear Rail Bottom"));
		}
	}

	class AnimatedStillSprite : Common.AnimatedStillSprite
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -6752);
			var art = indexer.ToArray();

			BuildSpritesSubtypes(
				new AnimatedStillSpriteData(2, art, 9, 2, true, 4, "Lava Surface"));
		}
	}

	class AnimatedStillSprite2 : Common.AnimatedStillSprite
	{
		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis);

			BuildSpritesSubtypes(
				new AnimatedStillSpriteData(3, art, 11, 1, false, 6, "Pulley"));
		}
	}
}

namespace S3KObjectDefinitions.DEZ
{
	class StillSprite : Common.StillSprite
	{
		public override void Init(ObjectData data)
		{
			var bytes = new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(bytes, -5696);
			var art1 = indexer.ToArray();
			indexer.AddFile(bytes, -1792);
			var art2 = indexer.ToArray();

			BuildSpritesSubtypes(
				new StillSpriteData(art1, 48, 1, false, 5, "Horizontal Beam Platform Shooter"),
				new StillSpriteData(art1, 49, 1, false, 5, "Vertical Beam Platform Shooter"),
				new StillSpriteData(art2, 50, 1, false, 1, "Light Tunnel Post"));
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class AnimatedStillSprite : StillSprite
	{
		public override string Name
		{
			get { return "Animated Decorative Sprite"; }
		}

		protected void BuildSpritesSubtypes(params AnimatedStillSpriteData[] subtypes)
		{
			BuildSpritesSubtypes("../Levels/Misc/Map - Animated Still Sprites.asm", subtypes);
		}

		protected class AnimatedStillSpriteData : StillSpriteData
		{
			private byte subtype;

			public override byte SubType
			{
				get { return subtype; }
			}

			public AnimatedStillSpriteData(byte subtype, byte[] art, byte frame, byte pal,
				bool pri, byte depth, string name) : base(art, frame, pal, pri, depth, name)
			{
				this.subtype = subtype;
			}
		}
	}

	abstract class StillSprite : ObjectDefinition
	{
		private Dictionary<byte, SubtypeData> subtypeData;
		private ReadOnlyCollection<byte> subtypes;
		private byte defaultSubtype;
		private Sprite defaultSprite;
		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Decorative Sprite"; }
		}

		public override Sprite Image
		{
			get { return defaultSprite; }
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
			return subtypeData[subtype].Name;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			SubtypeData data;
			var sprite = subtypeData.TryGetValue(subtype, out data) ? data.Sprite : unknownSprite;
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			SubtypeData data;
			var sprite = subtypeData.TryGetValue(obj.SubType, out data) ? data.Sprite : unknownSprite;
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bounds = GetSprite(obj).Bounds;
			var overlay = new BitmapBits(bounds.Size);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);

			return new Sprite(overlay, bounds.X, bounds.Y);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			SubtypeData data;
			return subtypeData.TryGetValue(obj.SubType, out data) ? data.Depth : 0;
		}

		protected void BuildSpritesSubtypes(params StillSpriteData[] subtypes)
		{
			BuildSpritesSubtypes("../Levels/Misc/Map - Still Sprites.asm", subtypes);
		}

		protected void BuildSpritesSubtypes(string mapfile, params StillSpriteData[] data)
		{
			var map = LevelData.ASMToBin(mapfile, LevelData.Game.MappingsVersion);
			subtypeData = System.Linq.Enumerable.ToDictionary(data, s => s.SubType, s => new SubtypeData
			{
				Name = s.name,
				Depth = s.depth,
				Sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(s.art, map, s.frame, s.pal, s.pri))
			});

			subtypes = new ReadOnlyCollection<byte>(System.Linq.Enumerable.ToArray(subtypeData.Keys));
			defaultSubtype = data[0].SubType;
			defaultSprite = subtypeData[defaultSubtype].Sprite[0];
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		protected class StillSpriteData
		{
			public byte[] art;
			public byte frame;
			public byte pal;
			public bool pri;
			public byte depth;
			public string name;

			public virtual byte SubType
			{
				get { return frame; }
			}

			public StillSpriteData(byte[] art, byte frame, byte pal, bool pri, byte depth, string name)
			{
				this.art = art;
				this.frame = frame;
				this.pal = pal;
				this.pri = pri;
				this.depth = depth;
				this.name = name;
			}
		}

		protected class SubtypeData
		{
			public string Name;
			public int Depth;
			public Sprite[] Sprite;
		}
	}
}

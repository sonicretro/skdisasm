using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class HiddenMonitor : Monitor
	{
		public override string Name
		{
			get { return "Hidden Monitor"; }
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}
	}

	class Monitor : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Monitor"; }
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
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../General/Sprites/Monitors/Monitors.bin", CompressionType.Nemesis)), 0);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../General/Sprites/HUD Icon/Sonic Life Icon.bin", CompressionType.Nemesis)), 25088);

			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../General/Sprites/Monitors/Map - Monitor.asm", LevelData.Game.MappingsVersion);

			subtypeNames = new[]
			{
				"Static",
				"1-Up",
				"Eggman",
				"Rings",
				"Speed Shoes",
				"Flame Barrier",
				"Thunder Barrier",
				"Aqua Barrier",
				"Invincibility",
				"Super"
			};

			var subtypes = new byte[subtypeNames.Length];
			subtypes[1] = 1;

			sprites = new Sprite[subtypeNames.Length][];
			sprites[0] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 0));
			sprites[1] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 2, 0));

			var index = 2;
			while (index < subtypeNames.Length)
			{
				subtypes[index] = (byte)index;
				sprites[index++] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 0));
			}

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
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
			return subtype < sprites.Length ? sprites[subtype] : unknownSprite;
		}
	}
}

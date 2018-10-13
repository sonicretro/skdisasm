using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HPZ
{
	class Platform : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Platform"; }
		}

		public override Sprite Image
		{
			get { return sprites[0]; }
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
			return sprites[subtype == 4 ? 2 : 0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (obj.SubType > 4)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			if (obj.SubType != 0)
				return sprites[obj.SubType == 4 ? 2 : obj.SubType != 3 ? 1 : 0];

			var sprite = new List<Sprite>();
			sprite.Add(sprites[1]);
			var yoffset = 0;

			for (var index = 0; index < 3; index++)
			{
				yoffset += 192;
				sprite.Add(new Sprite(sprites[1], 0, yoffset));
			}

			return new Sprite(sprite);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType > 4)
				return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var bounds = SubtypeImage(obj.SubType).Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
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

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Act 3 Platform.asm", version);

			subtypeNames = new[]
			{
				"Continuous Spawn",
				"Single (eager delete)",
				"Single (wait for autoscroll)",
				"Single (stationary)",
				"Solid Ledge"
			};

			var subtypes = new byte[subtypeNames.Length];
			for (var index = 0; index < subtypes.Length; index++)
				subtypes[index] = (byte)index;

			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 1, 3),
				ObjectHelper.MapToBmp(art, map, 2, 2),
				ObjectHelper.MapToBmp(art, map, 4, 3)
			};

			sprites[1] = new Sprite(sprites[0], sprites[1]);
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

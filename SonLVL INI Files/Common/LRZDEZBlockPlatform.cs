using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class FloatingPlatform : Common.LRZDEZBlockPlatform
	{
		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			base.Init(data);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Act 2 Extra Art.bin", CompressionType.Nemesis)), -256);

			sprites = new[]
			{
				ObjectHelper.MapASMToBmp(indexer.ToArray(),
					"../Levels/DEZ/Misc Object Data/Map - Floating Platform.asm", 0, 1)
			};
		}

		public override int GetSpriteIndex(byte subtype)
		{
			return 0;
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class SolidMovingPlatforms : Common.LRZDEZBlockPlatform
	{
		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			base.Init(data);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -4608);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Solid Moving Platforms.asm", version);

			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 0, 2),
				ObjectHelper.MapToBmp(art, map, 1, 2)
			};

			properties = new[]
			{
				properties[0],
				new PropertySpec("Sprite", typeof(int), "Extended",
				"The object's appearance.", null, new Dictionary<string, int>
				{
					{ "Block", 0x00 },
					{ "Platform", 0x10 }
				},
				(obj) => obj.SubType & 0x70,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((int)value & 0x70)))
			};
		}

		public override int GetSpriteIndex(byte subtype)
		{
			return (subtype & 0x70) >> 4;
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class LRZDEZBlockPlatform : ObjectDefinition
	{
		protected PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		protected Sprite[] sprites;

		private Sprite[] unknownSprite;


		public override string Name
		{
			get { return "Block Platform"; }
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
			var index = GetSpriteIndex(obj.SubType);
			if (index < sprites.Length)
			{
				var sprite = sprites[index];

				switch (obj.SubType & 0x0F)
				{
					case 0x00: return sprite;
					case 0x01: return new Sprite(sprite, obj.XFlip ? 0x20 : -0x20, 0);
					case 0x02: return new Sprite(sprite, obj.XFlip ? 0x40 : -0x40, 0);
					case 0x03: return new Sprite(sprite, obj.XFlip ? 0x60 : -0x60, 0);
					case 0x04: return new Sprite(sprite, 0, obj.XFlip ? 0x20 : -0x20);
					case 0x05: return new Sprite(sprite, 0, obj.XFlip ? 0x40 : -0x40);
					case 0x06: return new Sprite(sprite, 0, obj.XFlip ? 0x60 : -0x60);
					case 0x07: return new Sprite(sprite, obj.XFlip ? 0x80 : -0x80, 0);
					case 0x08: return new Sprite(sprite, 0, obj.XFlip ? 0x80 : -0x80);
				}
			}

			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = GetSpriteIndex(obj.SubType);
			if (index < sprites.Length)
			{
				switch (obj.SubType & 0x0F)
				{
					case 0x01: return Line(0x40, 0);
					case 0x02: return Line(0x80, 0);
					case 0x03: return Line(0xC0, 0);
					case 0x04: return Line(0, 0x40);
					case 0x05: return Line(0, 0x80);
					case 0x06: return Line(0, 0xC0);
					case 0x07: return Line(0x100, 0);
					case 0x08: return Line(0, 0x100);
				}
			}

			return null;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -4608);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Solid Moving Platforms.asm", version);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "None", 0 },
					{ "Vertical (64px)", 4 },
					{ "Vertical (128px)", 5 },
					{ "Vertical (192px)", 6 },
					{ "Vertical (256px)", 8 },
					{ "Horizontal (64px)", 1 },
					{ "Horizontal (128px)", 2 },
					{ "Horizontal (192px)", 3 },
					{ "Horizontal (256px)", 7 }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite Line(int width, int height)
		{
			var overlay = new BitmapBits(width + 1, height + 1);
			overlay.DrawLine(LevelData.ColorWhite, 0, height, width, 0);
			return new Sprite(overlay, -width / 2, -height / 2);
		}

		public abstract int GetSpriteIndex(byte subtype);
	}
}

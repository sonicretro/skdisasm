using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.ICZ
{
	class PathFollowPlatform : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[][] sprites;

		private Sprite[] overlays;

		public override string Name
		{
			get { return "Sliding Ice Block"; }
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
			return subtypeNames[subtype >> 1];
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

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0x02)
			{
				var overlay = new BitmapBits(0x80, 1);
				overlay.DrawLine(LevelData.ColorWhite, 0x00, 0, 0x03, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x08, 0, 0x0B, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x10, 0, 0x13, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x18, 0, 0x67, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x6C, 0, 0x6F, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x74, 0, 0x77, 0);
				overlay.DrawLine(LevelData.ColorWhite, 0x7C, 0, 0x7F, 0);
				return new Sprite(overlay, -0x40, 0);
			}

			if (obj.SubType == 0x06)
			{
				var overlay = new BitmapBits(1, 0x40);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0x00, 0, 0x1F);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0x24, 0, 0x27);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0x2C, 0, 0x2F);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0x34, 0, 0x37);
				overlay.DrawLine(LevelData.ColorWhite, 0, 0x3C, 0, 0x3F);
				return new Sprite(overlay);
			}

			return null;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprites[0][0].Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			subtypeNames = new[]
			{
				"Collapsing",
				"Pushable",
				"Stationary",
				"Floating"
			};

			var subtypes = new byte[subtypeNames.Length];
			for (var index = 0; index < subtypeNames.Length; index++)
				subtypes[index] = (byte)(index << 1);

			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
			sprites = new Sprite[3][];

			sprites[0] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/ICZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis),
				"../Levels/ICZ/Misc Object Data/Map - Platforms.asm", 0, 2));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			var extra = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/ICZ/Misc Object Data/Map - Wall and Column.asm", 8, 2);

			extra.Offset(-16, 16);
			sprites[1] = new Sprite[4];

			for (var index = 0; index < 4; index++)
				sprites[1][index] = new Sprite(extra, sprites[0][index]);

			sprites[2] = BuildFlippedSprites(ObjectHelper.UnknownObject);
			overlays = new Sprite[2];

			var overlay = new BitmapBits(0x80, 1);
			overlay.DrawLine(LevelData.ColorWhite, 0x00, 0, 0x03, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x08, 0, 0x0B, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x10, 0, 0x13, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x18, 0, 0x67, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x6C, 0, 0x6F, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x74, 0, 0x77, 0);
			overlay.DrawLine(LevelData.ColorWhite, 0x7C, 0, 0x7F, 0);
			overlays[0] = new Sprite(overlay, -0x40, 0);

			overlay = new BitmapBits(1, 0x40);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x00, 0, 0x1F);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x24, 0, 0x27);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x2C, 0, 0x2F);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x34, 0, 0x37);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0x3C, 0, 0x3F);
			overlays[1] = new Sprite(overlay);
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
			if (subtype != (subtype & 6)) return 2;
			return subtype == 0 ? 1 : 0;
		}
	}
}

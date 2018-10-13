using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class TriggerPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Trigger Platform"; }
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
			var index = GetSpriteIndex(subtype);
			return sprites[index][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = GetSpriteIndex(obj.SubType);
			return GetFlippedSprite(obj, index);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var movement = obj.SubType >> 4;
			if (movement > 2) return null;

			int xoffset = 0, yoffset = 0;

			if (movement == 0)
				xoffset = obj.XFlip ? -128 : 128;
			else
			{
				yoffset = movement * (obj.XFlip ? -64 : 64);
				movement = 1;
			}

			var sprite = GetFlippedSprite(obj, movement);
			var bitmap = new BitmapBits(sprite.Width, sprite.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, sprite.Width - 1, sprite.Height - 1);

			return new Sprite(bitmap, sprite.X + xoffset, sprite.Y + yoffset);
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
			var map = LevelData.ASMToBin("../Levels/MGZ/Misc Object Data/Map - Trigger Platform.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 2)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 1, 2)),
				BuildFlippedSprites(ObjectHelper.UnknownObject)
			};

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's appearance and movement pattern.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0 },
					{ "Vertical (64px)", 1 },
					{ "Vertical (128px)", 2 }
				},
				(obj) => (obj.SubType & 0x70) >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | (((int)value << 4) & 0x70)));

			properties[1] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag monitored by this object.", null,
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

		private int GetSpriteIndex(byte subtype)
		{
			if (subtype < 0x10) return 0;
			if (subtype >= 0x30) return 2;
			return 1;
		}

		private Sprite GetFlippedSprite(ObjectEntry obj, int index)
		{
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class SwingingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Swinging Platform"; }
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
			var count = obj.SubType & 0x0F;
			if (count > 8) return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var sprite = new Sprite(sprites[0]);
			var vertical = (obj.SubType & 0xF0) != 0;

			if (vertical)
			{
				var offset = obj.YFlip ? -16 : 16;
				sprite.Offset(obj.XFlip ? 24 : -24, offset >> 1);

				for (var index = 0; index < count; index++)
				{
					sprite = new Sprite(sprites[1], sprite);
					sprite.Offset(0, offset);
				}

				sprite.Offset(0, offset >> 1);
			}
			else
			{
				var offset = obj.XFlip ? 16 : -16;
				sprite.Offset(offset >> 1, 0);

				for (var index = 0; index < count; index++)
				{
					sprite = new Sprite(sprites[1], sprite);
					sprite.Offset(offset, 0);
				}

				sprite.Offset(offset >> 1, 0);
			}

			return new Sprite(sprites[2], sprite);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return null;

			var radius = (count + 1) * 16;
			var vertical = (obj.SubType & 0xF0) != 0;

			if (vertical)
			{
				var bitmap = new BitmapBits(radius + 1, radius * 2 + 1);
				bitmap.DrawCircle(LevelData.ColorWhite, obj.XFlip ? 0 : radius, radius, radius);
				return new Sprite(bitmap, obj.XFlip ? 24 : -radius - 24, -radius);
			}
			else
			{
				var bitmap = new BitmapBits(radius * 2 + 1, radius + 1);
				bitmap.DrawCircle(LevelData.ColorWhite, radius, obj.YFlip ? 0 : radius, radius);
				return new Sprite(bitmap, -radius, obj.YFlip ? 0 : -radius);
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var radius = (count + 1) * 16;
			var bounds = sprites[0].Bounds;
			var vertical = (obj.SubType & 0xF0) != 0;

			if (vertical)
			{
				var xoffset = obj.XFlip ? 24 : -24;
				var yoffset = obj.YFlip ? -radius : radius;
				bounds.Offset(obj.X + xoffset, obj.Y + yoffset);
				return bounds;
			}

			bounds.Offset(obj.X + (obj.XFlip ? radius : -radius), obj.Y);
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
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SOZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), 30976);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/SOZ/Misc Object Data/Map - Swinging Platform.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[3];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 2);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of segments in the object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (int)value));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0x00 },
					{ "Vertical", 0x10 }
				},
				(obj) => (obj.SubType & 0xF0) == 0 ? 0x00 : 0x10,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | (int)value));
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

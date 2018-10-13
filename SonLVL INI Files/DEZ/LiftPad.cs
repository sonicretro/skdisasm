using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class LiftPad : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Lift Pad"; }
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
			return sprites[0][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var sprites = this.sprites[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			var sprite = new Sprite(sprites[0]);
			var vertical = (obj.SubType & 0x20) != 0;

			if (vertical)
			{
				var offset = (obj.SubType & 0x10) == 0 ? -16 : 16;
				sprite.Offset(obj.XFlip ? 32 : -32, offset);

				for (var index = 0; index < count; index++)
				{
					sprite = new Sprite(sprites[1], sprite);
					sprite.Offset(0, offset);
				}
			}
			else
			{
				var offset = obj.XFlip ? 16 : -16;
				sprite.Offset(offset * 3, 0);

				for (var index = 0; index < count; index++)
				{
					sprite = new Sprite(sprites[1], sprite);
					sprite.Offset(offset, 0);
				}
			}

			return new Sprite(sprites[2], sprite);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return null;

			var radius = (count + 1) * 16;
			var bitmap = new BitmapBits(radius + 1, radius + 1);
			bitmap.DrawCircle(LevelData.ColorWhite, 0, 0, radius);
			var overlay = new Sprite(bitmap, 32, 0);

			overlay.Flip(!obj.XFlip, (obj.SubType & 0x10) == 0);
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = obj.SubType & 0x0F;
			if (count > 8) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var radius = (count + 1) * 16;
			var bounds = new Rectangle(-24, -8, 48, 16);
			var vertical = (obj.SubType & 0x20) != 0;

			if (vertical)
			{
				var xoffset = obj.XFlip ? 32 : -32;
				var yoffset = (obj.SubType & 0x10) == 0 ? -radius : radius;
				bounds.Offset(obj.X + xoffset, obj.Y + yoffset);
				return bounds;
			}

			radius = radius + 32;
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
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Miniboss.bin", CompressionType.Nemesis)), -192);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/DEZ/Misc Object Data/Map - Lift Pad.asm", version);

			var sprites = new Sprite[3];
			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 1);

			var flipped = new[]
			{
				new Sprite(sprites[0], false, true),
				new Sprite(sprites[1], false, true),
				new Sprite(sprites[2], false, true)
			};

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			this.sprites = new[]
			{
				sprites, new[] { new Sprite(sprites[0], true, false), sprites[1], sprites[2] },
				flipped, new[] { new Sprite(flipped[0], true, false), flipped[1], flipped[2] }
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of segments in the object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (int)value));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's initial orientation.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0x00 },
					{ "Vertical", 0x20 }
				},
				(obj) => obj.SubType & 0x20,
				(obj, value) =>
				{
					var direction = (int)value & 0x20;
					var movement = ((obj.SubType & 0x20) ^ direction) >> 1;
					obj.SubType = (byte)((obj.SubType & 0xDF) ^ movement | direction);
				});

			properties[2] = new PropertySpec("Movement", typeof(int), "Extended",
				"The direction of the object's movement.", null, new Dictionary<string, int>
				{
					{ "Up", 0x00 },
					{ "Down", 0x10 }
				},
				(obj) => (obj.SubType & 0x10) ^ ((obj.SubType & 0x20) >> 1),
				(obj, value) =>
				{
					var direction = obj.SubType & 0x20;
					var movement = ((int)value & 0x10) ^ (direction >> 1);
					obj.SubType = (byte)((obj.SubType & 0xEF) | movement);
				});
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

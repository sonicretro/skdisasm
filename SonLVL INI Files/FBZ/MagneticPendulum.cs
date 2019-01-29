using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class MagneticPendulum : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Magnetic Pendulum"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			return image;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprites[obj.SubType < 0x80 ? 0 : 1][obj.XFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType < 0x80)
			{
				var bitmap = new BitmapBits(225, 113);
				bitmap.DrawCircle(LevelData.ColorWhite, 112, 112, 112);
				return new Sprite(bitmap, -112, -112);
			}
			else
			{
				var bitmap = new BitmapBits(113, 225);
				bitmap.DrawCircle(LevelData.ColorWhite, 0, 112, 112);
				var overlay = new Sprite(bitmap, 0, -112);

				if (obj.XFlip) overlay.Flip(true, false);
				return overlay;
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var xoffset = obj.SubType < 0x80 ? -128 : -16;
			var yoffset = obj.SubType < 0x80 ? -16 : -128;
			return new Rectangle(obj.X + xoffset, obj.Y + yoffset, 32, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis)), -2592);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Magnetic Pendulum.asm", version);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			var frames = new Sprite[4];

			for (var index = 0; index < frames.Length; index++)
				frames[index] = ObjectHelper.MapToBmp(art, map, index, 1);

			image = frames[3];

			sprites = new[]
			{
				BuildFlippedSprites(frames, true),
				BuildFlippedSprites(frames, false)
			};

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0x00 },
					{ "Vertical", 0x80 }
				},
				(obj) => obj.SubType < 0x80 ? 0x00 : 0x80,
				(obj, value) => obj.SubType = (byte)(int)value);
		}

		private Sprite[] BuildFlippedSprites(Sprite[] frames, bool horizontal)
		{
			var xoffset = horizontal ? -17 : 0;
			var yoffset = horizontal ? 0 : -17;
			var sprite = new Sprite(frames[3], (xoffset / 2) * 3, (yoffset / 2) * 3);

			for (var index = 0; index < 5; index++)
			{
				sprite = new Sprite(frames[2], sprite);
				sprite.Offset(xoffset, yoffset);
			}

			sprite.Offset(xoffset / 5, yoffset / 5);
			sprite = new Sprite(sprite, frames[horizontal ? 0 : 1]);

			return new[] { sprite, new Sprite(sprite, true, false) };
		}
	}
}

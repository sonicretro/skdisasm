using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class SwingingSpikeBall : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite image;

		public override string Name
		{
			get { return "Swinging Spike Ball"; }
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
			return sprites[obj.SubType == 0 ? 0 : 1][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0)
			{
				var bitmap = new BitmapBits(192, 1);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 191, 0);
				return new Sprite(bitmap, -96, 0);
			}
			else
			{
				var bitmap = new BitmapBits(1, 192);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 0, 191);
				return new Sprite(bitmap, 0, -96);
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var xoffset = obj.SubType == 0 ? 64 : -32;
			var yoffset = obj.SubType == 0 ? -32 : 64;
			return new Rectangle(obj.X + xoffset, obj.Y + yoffset, 64, 64);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/MGZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/MGZ/Misc Object Data/Map - Swinging Spike Ball.asm", version);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[2][];

			var frames = new Sprite[4];
			for (var index = 0; index < frames.Length; index++)
				frames[index] = ObjectHelper.MapToBmp(art, map, index, 1);

			sprites[0] = BuildFlippedSprites(frames, true);
			sprites[1] = BuildFlippedSprites(frames, false);
			image = frames[3];

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Horizontal", 0 },
					{ "Vertical", 1 }
				},
				(obj) => obj.SubType == 0 ? 0 : 1,
				(obj, value) => obj.SubType = (byte)(int)value);
		}

		private Sprite[] BuildFlippedSprites(Sprite[] frames, bool horizontal)
		{
			var sprites = new Sprite[4];

			if (horizontal)
			{
				sprites[0] = BuildSprite(frames, true, false);
				sprites[1] = BuildSprite(frames, true, true);
				sprites[2] = new Sprite(sprites[0], false, true);
				sprites[3] = new Sprite(sprites[1], false, true);
			}
			else
			{
				sprites[0] = BuildSprite(frames, false, false);
				sprites[2] = BuildSprite(frames, false, true);
				sprites[1] = new Sprite(sprites[0], true, false);
				sprites[3] = new Sprite(sprites[2], true, false);
			}

			return sprites;
		}

		private Sprite BuildSprite(Sprite[] frames, bool horizontal, bool flip)
		{
			var xoffset = horizontal ? flip ? -16 : 16 : 0;
			var yoffset = horizontal ? 0 : flip ? -16 : 16;
			var sprite = new Sprite(frames[3], xoffset * 2, yoffset * 2);

			for (var index = 0; index < 4; index++)
			{
				sprite = new Sprite(frames[0], sprite);
				sprite.Offset(xoffset, yoffset);
			}

			sprite = new Sprite(sprite, frames[horizontal ? 1 : 2]);
			sprite.Flip(horizontal && flip, !horizontal && flip);
			return sprite;
		}
	}
}

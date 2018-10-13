using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class Fan : Common.HCZCGZFan
	{
		private Sprite block;
		private Sprite overlay;

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var sprite = base.GetSprite(obj);
			return (obj.SubType & 0x80) == 0 ? sprite : new Sprite(sprite, block);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var sprite = base.GetDebugOverlay(obj);
			if ((obj.SubType & 0x80) == 0)
				return sprite;

			var offset = (obj.SubType & 0x30) * 2;
			if (offset == 0)
				return sprite;
			if (obj.XFlip)
				offset = -offset;

			sprite.Offset(-offset, 0);
			sprite = new Sprite(sprite, overlay);
			sprite.Offset(offset, 0);

			return sprite;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var tiles = new List<byte>(
				LevelData.ReadFile("../Levels/HCZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis));

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(tiles, -2080);
			BuildSpritesProperties(indexer.ToArray(), "../Levels/HCZ/Misc Object Data/Map - Fan.asm", 1);

			indexer.AddFile(tiles, -320);
			block = ObjectHelper.MapASMToBmp(
				indexer.ToArray(), "../Levels/HCZ/Misc Object Data/Map - Water Rush Block.asm", 0, 2);
			block.Offset(0, 28);

			var overlay = new BitmapBits(block.Width, block.Height);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, overlay.Width - 1, overlay.Height - 1);
			this.overlay = new Sprite(overlay, block.X, block.Y);

			properties = new PropertySpec[]
			{
				properties[0],
				new PropertySpec("Bubbles", typeof(bool), "Extended",
					"If set, the object will spawn bubbles while it is active.", null,
					(obj) => (obj.SubType & 0x40) != 0,
					(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0))),
				new PropertySpec("Behavior", typeof(int), "Extended",
					"The conditions under which the object becomes active.", null, new Dictionary<string, int>
					{
						{ "Periodic", 0x00 },
						{ "Constant", 0x10 },
						{ "Level trigger", 0x20 },
						{ "Block (constant)", 0x80 },
						{ "Block (32px retracting)", 0x90 },
						{ "Block (64px retracting)", 0xA0 },
						{ "Block (96px retracting)", 0xB0 },
					},
					(obj) => { var index = obj.SubType & 0xB0; return index == 0x30 ? 0x20 : index; },
					(obj, value) => obj.SubType = (byte)((obj.SubType & 0x4F) | ((int)value & 0xB0)))
			};
		}
	}
}

namespace S3KObjectDefinitions.CGZ
{
	class Fan : Common.HCZCGZFan
	{
		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile("../Levels/CGZ/Nemesis Art/Platform.bin", CompressionType.Nemesis);
			BuildSpritesProperties(art, "../Levels/CGZ/Misc Object Data/Map - Fan.asm", 3);
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class HCZCGZFan : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[] sprite;

		public override string Name
		{
			get { return "Fan"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var range = ((obj.SubType & 0x0F) + 8) << 4;
			var overlay = new BitmapBits(17, range);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, 16, 0);
			overlay.DrawLine(LevelData.ColorWhite, 8, 0, 8, range);
			return new Sprite(overlay, -8, -range - 4);
		}

		protected void BuildSpritesProperties(byte[] art, string mapfile, int startpal)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art, mapfile, 0, startpal));

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"The minimum height at which the player will float, in pixels.", null,
				(obj) => ((obj.SubType & 0x0F) + 8) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((((int)value >> 4) - 8) & 0x0F)));
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

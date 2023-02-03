using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class Teleporter : Common.SSZHPZTeleporter
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SSZ/Nemesis Art/Misc.bin", CompressionType.Nemesis)), -4352);

			BuildSpritesProperties(indexer.ToArray(), 0, 0);
		}
	}
}

namespace S3KObjectDefinitions.HPZ
{
	class Teleporter : Common.SSZHPZTeleporter
	{
		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../General/Sprites/Teleporter/Teleporter.bin", CompressionType.KosinskiM);

			BuildSpritesProperties(art, 10, 4);
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class SSZHPZTeleporter : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Teleporter"; }
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
			var sprite = this.sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			if (obj.SubType < 0x80) return sprite;

			return new Sprite(sprite, 0, 32);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;

			var hidden = obj.SubType >= 0x80;
			var height = (hidden ? ((obj.SubType & 0x3F) + 6) : ((obj.SubType & 0x7F) + 3)) << 4;

			var bitmap = new BitmapBits(48, height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 47, 31);
			bitmap.DrawLine(LevelData.ColorWhite, 24, 32, 24, hidden ? height - 32 : height);

			if (hidden) bitmap.DrawRectangle(LevelData.ColorWhite, 0, height - 32, 47, 31);
			return new Sprite(bitmap, -24, (hidden ? 48 : 0) - height);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		protected void BuildSpritesProperties(byte[] art, int frame, int startpal)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../General/Sprites/Teleporter/Map - Teleporter.asm", frame, startpal));

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Vertical distance the player will travel, in pixels.", null,
				(obj) =>
				{
					var hidden = obj.SubType >= 0x80;
					return (obj.SubType & (hidden ? 0x3F : 0x7F)) << 4;
				},
				(obj, value) =>
				{
					var hidden = obj.SubType >= 0x80;
					obj.SubType = (byte)(hidden ? (((int)value >> 4) & 0x7F)
						: ((obj.SubType & 0xC0) | (((int)value >> 4) & 0x3F)));
				});

			properties[1] = new PropertySpec("Reveal From", typeof(bool), "Extended",
				"If set, the object will rise up once a boss is defeated.", null, new Dictionary<string, int>
				{
					{ "Start", 0x00 },
					{ "Sonic 1 Boss", 0x80 },
					{ "Sonic 2 Boss", 0xC0 }
				},
				(obj) => obj.SubType < 0x80 ? 0 : (obj.SubType & 0xC0),
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x3F) | ((int)value & 0xC0)));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class SmashingPillar : Common.MGZLBZSmashingPillar
	{
		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(sprite, 0, obj.SubType << 3);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/MGZ/Misc Object Data/Map - Smashing Pillar.asm");
		}
	}
}

namespace S3KObjectDefinitions.LBZ
{
	class SmashingPillar : Common.MGZLBZSmashingPillar
	{
		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return new Sprite(overlay, 0, obj.SubType << 3);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Tube Transport.bin", CompressionType.Nemesis);
			BuildSpritesProperties(art,
				"../Levels/LBZ/Misc Object Data/Map - Smashing Spikes.asm");
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class MGZLBZSmashingPillar : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		protected Sprite sprite;
		protected Sprite overlay;

		public override string Name
		{
			get { return "Spiked Crusher"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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
			return sprite;
		}

		protected void BuildSpritesProperties(byte[] art, string mapfile)
		{
			sprite = ObjectHelper.MapASMToBmp(art, mapfile, 0, 2);
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];

			var bitmap = new BitmapBits(sprite.Width, sprite.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, sprite.Width - 1, sprite.Height - 1);
			overlay = new Sprite(bitmap, sprite.X, sprite.Y);

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"How far the object will rise before falling, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}
	}
}

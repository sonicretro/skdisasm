using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class Door2 : Door
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -4608);
			BuildSpritesProperties(indexer.ToArray(), 1);
		}
	}

	class Door : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Door"; }
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
			var bitmap = new BitmapBits(32, sprite[0].Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, sprite[0].Height - 1);
			return new Sprite(bitmap, -16, sprite[0].Y - 64);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis), 0);
		}

		protected void BuildSpritesProperties(byte[] art, int frame)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../Levels/LRZ/Misc Object Data/Map - Door.asm", frame, 2));

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag monitored by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((int)value & 0x0F));
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

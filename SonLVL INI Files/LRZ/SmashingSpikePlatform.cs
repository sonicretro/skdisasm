using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class SmashingSpikePlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Smashing Spike Platform"; }
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
			var height = obj.SubType << 3;

			var bitmap = new BitmapBits(128, 64);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 127, 63);
			return new Sprite(bitmap, -64, height - 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), 0);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Spike Crush.bin", CompressionType.Nemesis)), 4832);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/LRZ/Misc Object Data/Map - Smashing Spike Platform.asm", 8, 2));

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"How far the object will rise before falling, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
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

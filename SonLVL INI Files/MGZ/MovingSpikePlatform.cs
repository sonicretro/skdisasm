using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class MovingSpikePlatform : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Spiked Pillar"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			var overlay = new BitmapBits(161, 1);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, 160, 0);
			return new Sprite(overlay, -80, 12);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/MGZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis)), 32704);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/MGZ/Misc Object Data/Map - Moving Spike Platform.asm", 0, 2));
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

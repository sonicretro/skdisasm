using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class ElevatorBar : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;
		private Sprite overlay;

		public override string Name
		{
			get { return "Elevator Bar"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SSZ/Nemesis Art/Misc.bin", CompressionType.Nemesis)), -3712);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/SSZ/Misc Object Data/Map - Elevator Bar.asm", 0, 2);

			var bitmap = new BitmapBits(32, 129);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, 31, 0);
			bitmap.DrawLine(LevelData.ColorWhite, 16, 0, 16, 128);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 128, 31, 128);

			overlay = new Sprite(bitmap, -16, -64);
		}
	}
}

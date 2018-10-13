using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Pachinko
{
	class TriangleBumper : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Triangle Bumper"; }
		}

		public override bool Debug
		{
			get { return true; }
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
			return overlay;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 0x12, obj.Y - 0x40, 0x24, 0x80);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/Pachinko/Nemesis Art/Main.bin", CompressionType.Nemesis)), -960);
			var frame = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/Pachinko/Misc Object Data/Map - Triangle Bumper.asm", 2, 3);

			frame.InvertPriority();

			sprite = BuildFlippedSprites(frame);
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);

			var bitmap = new BitmapBits(0x24, 0x80);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 0x23, 0x7F);
			overlay = new Sprite(bitmap, -0x12, -0x40);
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

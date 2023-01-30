using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Gumball
{
	class GumballMachine : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;
		private Sprite childSprite;

		private Sprite image;

		public override string Name
		{
			get { return "Gumball Machine"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			return new Sprite(sprite, new Sprite(childSprite, 256 - obj.X, 784 - obj.Y));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 64, obj.Y - 328, 128, 128);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 2;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/Gumball/Nemesis Art/Gumball Bonus.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/Gumball/Misc Object Data/Map - Gumball Bonus.asm", version);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../General/Sprites/Level Misc/SpikesSprings.bin", CompressionType.Nemesis)), -512);

			var spring1 = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../General/Sprites/Level Misc/Map - Spring.asm", "word_23788", 0);

			spring1.Offset(-48, -24);
			var spring2 = new Sprite(spring1, 32, 0);
			var spring3 = new Sprite(spring1, 64, 0);
			var spring4 = new Sprite(spring1, 96, 0);

			var reflection = ObjectHelper.MapToBmp(art, map, 0, 0, false);
			var reflection2 = new Sprite(reflection);
			reflection.Offset(-56, -300);
			reflection2.Offset(56, -300);

			var shine = ObjectHelper.MapToBmp(art, map, 1, 0, false);
			shine.Offset(0, -300);

			var lid = ObjectHelper.MapToBmp(art, map, 2, 1, true);
			lid.Offset(0, -220);

			var handle = ObjectHelper.MapToBmp(art, map, 5, 1, true);
			handle.Offset(0, -256);

			var block = ObjectHelper.MapToBmp(art, map, 19, 1, false);
			image = ObjectHelper.MapToBmp(art, map, 22, 0, false);
			childSprite = new Sprite(block, spring1, spring2, spring3, spring4);

			var bitmapHigh = new BitmapBits(112, 39);
			bitmapHigh.DrawSpriteHigh(image, 56, 15);
			var gumballs = new Sprite(image.GetBitmapLow(), bitmapHigh, -56, -311);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(gumballs, reflection, reflection2, shine, lid, handle);
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class RetractingSpring : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Retracting Spring"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
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
			return sprites[0][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var sprite = unknownSprite;
			if ((obj.SubType & 1) == 0)
				sprite = sprites[(obj.SubType >> 1) & 1];

			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if ((obj.SubType & 1) != 0) return null;

			var bitmap = new BitmapBits(32, 32);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 31);
			return new Sprite(bitmap, obj.YFlip ? -16 : obj.XFlip ? 16 : -48, -16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			var springs = new List<byte>(LevelData.ReadFile(
				"../General/Sprites/Level Misc/SpikesSprings.bin", CompressionType.Nemesis));
			indexer.AddFile(springs, 11328);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Act 2 Extra Art.bin", CompressionType.Nemesis)), 0);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[2][];
			sprites[0] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/DEZ/Misc Object Data/Map - Retracting Spring.asm", 0, 1));

			sprites[0][2].Offset(32, 0);
			sprites[0][3].Offset(-32, 0);
			sprites[1] = sprites[0];

			//indexer.AddFile(springs, -512);
			//var bitmap = sprites[0][0].GetBitmap();
			//bitmap.DrawSprite(ObjectHelper.MapASMToBmp(indexer.ToArray(),
			//	"../General/Sprites/Level Misc/Map - Spring.asm", "word_237BA", 0), 16, 0);

			//sprites[1] = BuildFlippedSprites(new Sprite(bitmap, -16, -16));
			//sprites[1][2].Offset(32, 0);
			//sprites[1][3].Offset(-32, 0);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Force", typeof(int), "Extended",
				"The spring's initial force.", null, new Dictionary<string, int>
				{
					{ "Red", 0x00 },
					{ "Yellow", 0x02 }
				},
				(obj) => obj.SubType & 0x02,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFD) | ((int)value & 0x02)));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class PlatformBlocks : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Block"; }
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
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var distance = (obj.SubType & 0x0F) << 4;
			if (distance == 0) return null;

			var count = ((obj.SubType >> 4) & 7) + 1;
			if (count > 4) return null;

			var bitmap = new BitmapBits(count * 32, 32);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bitmap.Width - 1, 31);
			return new Sprite(bitmap, (obj.XFlip ? -distance : distance) - count * 16, -16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -4736);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Platform Blocks.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8][];

			for (var index = 0; index < 4; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 2));

			sprites[4] = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprites[5] = sprites[4];
			sprites[6] = sprites[4];
			sprites[7] = sprites[4];

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of blocks in the object.", null,
				(obj) => ((obj.SubType >> 4) & 3) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((((int)value - 1) & 3) << 4)));

			properties[1] = new PropertySpec("Distance", typeof(int), "Extended",
				"How far the object will retract, in pixels.", null,
				(obj) => (obj.SubType & 0x0F) << 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value >> 4) & 0x0F)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[(subtype >> 4) & 7];
		}
	}
}

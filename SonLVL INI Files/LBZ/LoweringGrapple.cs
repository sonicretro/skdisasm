using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class LoweringGrapple : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Lowering Grapple"; }
		}

		public override Sprite Image
		{
			get { return sprites[0]; }
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
			return sprites[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var length = obj.SubType & 0x7F;
			if (length == 0) return sprites[0];

			var index = length / 2 + 1;
			if (index < sprites.Length) return new Sprite(sprites[index], 0, length << 3);

			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var length = obj.SubType & 0x7F;
			var index = length / 2 + 1;

			if (index < sprites.Length)
				return new Rectangle(obj.X - 8, obj.Y + (length << 3) + 96, 16, 32);

			return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis)), 0);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), 6944);

			var version = LevelData.Game.MappingsVersion;
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin("../Levels/LBZ/Misc Object Data/Map - Lowering Grapple.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[15];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 2);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of chain links in the object.", null,
				(obj) => obj.SubType & 0x7F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | ((int)value & 0x7F)));

			properties[1] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will start low and rise until fully retracted.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class RotatingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Rotating Platform"; }
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

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var width = 192 + ((obj.SubType & 1) << 7);

			var bitmap = new BitmapBits(width, 40);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, width - 1, 39);
			return new Sprite(bitmap, -width / 2, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 2;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/SSZ/Nemesis Art/Misc.bin", CompressionType.Nemesis)), -5440);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/SSZ/Misc Object Data/Map - Rotating Platform.asm", 0, 2);

			properties[0] = new PropertySpec("Size", typeof(int), "Extended",
				"The underlying platform's collision size.", null, new Dictionary<string, int>
				{
					{ "Small", 0 },
					{ "Large", 1 }
				},
				(obj) => obj.SubType & 1,
				(obj, value) => obj.SubType = (byte)((int)value & 1));
		}
	}
}

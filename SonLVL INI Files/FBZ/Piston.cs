using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class Piston : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Piston"; }
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
			if (obj.SubType == 0) return null;
			var range = obj.SubType << 3;

			var overlay = new BitmapBits(range, 1);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, range, 0);
			return new Sprite(overlay, -range, 0);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Outdoors.bin", CompressionType.Nemesis)), -1728);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/FBZ/Misc Object Data/Map - Piston.asm", 0, 1);

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Horizontal range patrolled by the object, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}
	}
}

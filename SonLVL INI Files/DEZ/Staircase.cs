using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class Staircase : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite image;

		public override string Name
		{
			get { return "Staircase"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			return image;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var down = (obj.SubType & 4) == 0;

			var offset = (obj.SubType & 1) == 0 ? 0 : down ? 32 : -32;
			var sprite = new Sprite(image, obj.YFlip ^ down, false);
			sprite = new Sprite(new Sprite(sprite, 32, offset), sprite);
			sprite = new Sprite(new Sprite(sprite, 64, offset << 1), sprite);

			sprite.Offset(obj.XFlip ? 0 : -96, offset);
			sprite.Flip(!obj.XFlip, obj.YFlip);
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if ((obj.SubType & 1) != 0) return null;

			var bitmap = new BitmapBits(128, 128);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 31);
			bitmap.DrawRectangle(LevelData.ColorWhite, 32, 32, 31, 31);
			bitmap.DrawRectangle(LevelData.ColorWhite, 64, 64, 31, 31);
			bitmap.DrawRectangle(LevelData.ColorWhite, 96, 96, 31, 31);

			var overlay = new Sprite(bitmap, obj.XFlip ? -16 : -112, 16);
			overlay.Flip(!obj.XFlip, (obj.SubType & 4) != 0);
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
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -9824);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			image = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/DEZ/Misc Object Data/Map - Tilting Bridge.asm", 0, 1);

			properties[0] = new PropertySpec("Automatic", typeof(bool), "Extended",
				"If set, the object will be activated from the start.", null, 
				(obj) => (obj.SubType & 1) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 6) | ((bool)value ? 1 : 0)));

			properties[1] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The direction from which the object can be activated.", null, new Dictionary<string, int>
				{
					{ "Top", 0 },
					{ "Bottom", 2 }
				},
				(obj) => obj.SubType & 2,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 5) | ((int)value & 2)));

			properties[2] = new PropertySpec("Direction", typeof(int), "Extended",
				"The direction of the object's movement.", null, new Dictionary<string, int>
				{
					{ "Up", 4 },
					{ "Down", 0 }
				},
				(obj) => obj.SubType & 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 3) | ((int)value & 4)));
		}
	}
}

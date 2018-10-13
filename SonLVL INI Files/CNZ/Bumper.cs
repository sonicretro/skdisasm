using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CNZ
{
	class Bumper : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Bumper"; }
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
			if (obj.SubType == 0)
				return new Sprite(sprite, obj.XFlip, obj.YFlip);

			var radians = Math.PI * (obj.SubType / 128.0);
			var xoffset = (int)(Math.Cos(radians) * 64.0);
			var yoffset = (int)(Math.Sin(radians) * 64.0);
			return new Sprite(sprite, xoffset, yoffset, obj.XFlip, obj.YFlip);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return obj.SubType == 0 ? null : overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -608);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../General/Sprites/Level Misc/Map - Bumper.asm", 0, 2);

			var bitmap = new BitmapBits(129, 129);
			bitmap.DrawCircle(LevelData.ColorWhite, 64, 64, 64);
			overlay = new Sprite(bitmap, -64, -64);

			properties[0] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's movement cycle.", null,
				(obj) => obj.XFlip ? 256 - obj.SubType : obj.SubType,
				(obj, value) => obj.SubType = (byte)(obj.XFlip ? 256 - (int)value : (int)value));

			properties[1] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will move counterclockwise.", null,
				(obj) => obj.XFlip,
				(obj, value) =>
				{
					obj.XFlip = (bool)value;
					obj.SubType = (byte)(256 - obj.SubType);
				});
		}
	}
}

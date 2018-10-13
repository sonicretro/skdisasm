using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MHZ
{
	class PulleyLift : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite image;

		private Sprite sprite;
		private Sprite flippedSprite;

		public override string Name
		{
			get { return "Pulley Lift"; }
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
			return obj.YFlip ? flippedSprite : sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;
			var range = obj.SubType << 4;

			var overlay = new BitmapBits(32, range);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, 32, 0);
			overlay.DrawLine(LevelData.ColorWhite, 16, 0, 16, range);
			return new Sprite(overlay, -16, -range - 16);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 62, obj.Y - 16, 124, 58);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/MHZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -7072);
			var map = LevelData.ASMToBin(
				"../Levels/MHZ/Misc Object Data/Map - Pulley Lift.asm", LevelData.Game.MappingsVersion);
			var art = indexer.ToArray();

			var ropes = ObjectHelper.MapToBmp(art, map, 0, 0);
			ropes.Offset(0, 64);

			var handleL = ObjectHelper.MapToBmp(art, map, 3, 0);
			handleL.Offset(-50, -6);
			var handleR = new Sprite(handleL, true, false);

			var main = ObjectHelper.MapToBmp(art, map, 4, 0);
			var toothL = ObjectHelper.MapToBmp(art, map, 5, 0);
			var toothR = ObjectHelper.MapToBmp(art, map, 6, 0);
			toothL.Offset(-16, 120);
			toothR.Offset(16, 120);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			image = new Sprite(handleL, handleR, main);

			sprite = new Sprite(toothL, toothR, handleL, handleR, ropes, main);
			main.Flip(false, true);
			ropes.Flip(false, true);
			toothL.Flip(false, true);
			toothR.Flip(false, true);
			ropes.Offset(0, 128);
			toothL.Offset(0, 240);
			toothR.Offset(0, 240);
			flippedSprite = new Sprite(toothL, toothR, handleL, handleR, ropes, main);

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"How far the object will rise before stopping, in pixels.", null,
				(obj) => obj.SubType << 4,
				(obj, value) => obj.SubType = (byte)((int)value >> 4));
		}
	}
}

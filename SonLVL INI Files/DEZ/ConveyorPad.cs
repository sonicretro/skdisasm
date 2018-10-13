using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class ConveyorPad : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Conveyor Pad"; }
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
			return sprites[obj.SubType == 0 ? 0 : 1][obj.YFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;

			var height = (obj.SubType & 0x7F) << 3;
			var bitmap = new BitmapBits(256, Math.Max(height + 16, 32));
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 255, 31);
			if (height > 16)
				bitmap.DrawLine(LevelData.ColorWhite, 128, 32, 128, bitmap.Height);

			var overlay = new Sprite(bitmap, -128, -height - 16);
			if (obj.SubType < 0x80) overlay.Flip(false, true);
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -5984);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/DEZ/Misc Object Data/Map - Conveyor Pad.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 1)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 4, 1))
			};

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Vertical distance the object will travel, in pixels.", null,
				(obj) => (obj.SubType & 0x7F) << 3,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | (((int)value & 0x7F) >> 3)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The direction of the object's movement.", null, new Dictionary<string, int>
				{
					{ "Up", 0x80 },
					{ "Down", 0 }
				},
				(obj) => obj.SubType & 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, false, true) };
		}
	}
}

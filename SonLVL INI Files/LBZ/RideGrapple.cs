using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class RideGrapple : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private int[] conveyorData;

		public override string Name
		{
			get { return "Ride Grapple"; }
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
			var index = (obj.SubType & 0x7F) << 1;
			if (index > conveyorData.Length) return null;

			var length = conveyorData[index + 1] - conveyorData[index];
			var overlay = new BitmapBits(length, 1);
			overlay.DrawLine(LevelData.ColorWhite, 0, 0, length, 0);

			return new Sprite(overlay, conveyorData[index] - obj.X, 0);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -3584);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/LBZ/Misc Object Data/Map - Ride Grapple.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(ObjectHelper.MapToBmp(art, map, 0, 1), ObjectHelper.MapToBmp(art, map, 2, 1));

			conveyorData = new[]
			{
				0xA08, 0xC78,
				0x1208, 0x14F8,
				0x1A08, 0x1BB8,
				0x1C48, 0x2078,
				0x2688, 0x2878,
				0x2988, 0x2DF8,
				0x2F88, 0x3178,
				0xE68, 0x1098,
				0xCE8, 0x1498,
				0xE68, 0x1398,
				0x20E8, 0x2418,
				0x2B08, 0x2E98,
				0x39E8, 0x3C98
			};

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x7F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x80) | ((int)value & 0x7F)));

			properties[1] = new PropertySpec("Launch", typeof(bool), "Extended",
				"If set, players will fall off the object at the end of its path.", null,
				(obj) => obj.SubType < 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x00 : 0x80)));
		}
	}
}

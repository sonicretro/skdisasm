using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class SpikeBall : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Spike Ball"; }
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
			var bitmap = new BitmapBits(128, 1);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 127, 0);
			return new Sprite(bitmap, -64, 0);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Big Spike Ball.bin", CompressionType.Nemesis),
				"../Levels/LRZ/Misc Object Data/Map - Spike Ball.asm", 0, 1);

			sprite.Offset(64, 0);

			properties[0] = new PropertySpec("Release", typeof(int), "Extended",
				"The point at which the object is released from its cycle.", null, new Dictionary<string, int>
				{
					{ "Never", 0x00 },
					{ "Center going right", 0x40 },
					{ "Far left", 0x80 },
					{ "Center going left", 0xC0 }
				},
				(obj) => (int)obj.SubType,
				(obj, value) => obj.SubType = (byte)(int)value);

			properties[1] = new PropertySpec("Floor Check", typeof(bool), "Extended",
				"If set, the object will match the floor height as it moves.", null,
				(obj) => obj.YFlip,
				(obj, value) => obj.YFlip = (bool)value);
		}
	}
}

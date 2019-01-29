using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class Elevator : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Elevator"; }
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
			var sprite = new Sprite(this.sprite);
			var count = (obj.SubType << 3) / 0x60;

			if (obj.XFlip)
			{
				for (var i = 0; i < count; i++)
				{
					sprite.Offset(0, 0x60);
					sprite = new Sprite(sprite, this.sprite);
				}
			}
			else
			{
				for (var i = 0; i < count; i++)
				{
					sprite.Offset(0, -0x60);
					sprite = new Sprite(sprite, this.sprite);
				}
			}

			return sprite;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis),
				"../Levels/FBZ/Misc Object Data/Map - Elevator.asm", 0, 2);

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Vertical distance the object will travel, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}
	}
}

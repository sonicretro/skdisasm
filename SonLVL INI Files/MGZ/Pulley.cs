using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class Pulley : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		public override string Name
		{
			get { return "Pulley"; }
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
			var sprite = new Sprite(sprites[2], false, obj.YFlip);
			var segment = new Sprite(sprites[1], false, obj.YFlip);

			var length = obj.SubType + 3;
			var numsegs = length / 6;
			var offset = (length % 6) * 4;

			for (var index = 0; index < numsegs; index++)
			{
				sprite.Offset(-24, 48);
				sprite = new Sprite(sprite, segment);
			}

			sprite.Offset(-offset - 12, (offset * 2) - 8);
			segment = new Sprite(sprites[0], false, obj.YFlip);

			sprite = new Sprite(sprite, segment);
			sprite.Flip(obj.XFlip, false);
			return sprite;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 32, obj.Y - 32, 64, 64);
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile("../Levels/MGZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/MGZ/Misc Object Data/Map - Pulley.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 0, 1),
				ObjectHelper.MapToBmp(art, map, 5, 1),
				ObjectHelper.MapToBmp(art, map, 6, 1)
			};

			properties[0] = new PropertySpec("Length", typeof(int), "Extended",
				"The vertical range of the object's string, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}
	}
}

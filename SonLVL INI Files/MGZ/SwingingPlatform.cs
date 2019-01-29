using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MGZ
{
	class SwingingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		public override string Name
		{
			get { return "Swinging Platform"; }
		}

		public override Sprite Image
		{
			get { return sprites[2]; }
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
			return sprites[2];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var radians = Math.PI * (obj.SubType / 128.0);
			var xoffset = Math.Cos(radians) * 16.0;
			var yoffset = Math.Sin(radians) * 16.0;

			var sprite = new Sprite(sprites[2], (int)(xoffset * 5), (int)(yoffset * 5));

			for (var index = 4; index > 0; index--)
			{
				var x = (int)(xoffset * index);
				var y = (int)(yoffset * index);
				sprite = new Sprite(new Sprite(sprites[0], x, y), sprite);
			}

			return obj.YFlip ? sprite : new Sprite(sprite, new Sprite(sprites[1]));
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bitmap = new BitmapBits(161, 161);
			bitmap.DrawCircle(LevelData.ColorWhite, 80, 80, 80);
			return new Sprite(bitmap, -80, -80);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var radians = Math.PI * (obj.SubType / 128.0);
			var xoffset = Math.Cos(radians) * 80.0;
			var yoffset = Math.Sin(radians) * 80.0;

			var bounds = sprites[2].Bounds;
			bounds.Offset(obj.X + (int)xoffset, obj.Y + (int)yoffset);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/MGZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/MGZ/Misc Object Data/Map - Swinging Platform.asm", version);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[3];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.MapToBmp(art, map, index, 2);

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

			properties[2] = new PropertySpec("Pivot", typeof(bool), "Extended",
				"If set, an extra sprite will be added at the object's center.", null,
				(obj) => !obj.YFlip,
				(obj, value) => obj.YFlip = !(bool)value);
		}
	}
}

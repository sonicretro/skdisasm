using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class SpikeBallLauncher : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		public override string Name
		{
			get { return "Spike Ball Launcher"; }
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
			var launchpad = sprites[obj.YFlip ? 1 : 0];
			if (obj.SubType == 0) return new Sprite(sprites[2], launchpad);

			var height = 0m;
			for (var speed = -obj.SubType / 16m; speed < 0m; speed += 0.21875m)
				height += speed;

			var yoffset = (int)decimal.Floor(height);
			return new Sprite(new Sprite(sprites[3], 0, yoffset), launchpad);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 16, obj.Y - 4, 32, 8);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Spike Ball Launcher.asm", version);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[4];

			sprites[2] = ObjectHelper.MapToBmp(art, map, 0, 1);
			sprites[3] = ObjectHelper.MapToBmp(art, map, 1, 1);
			sprites[0] = ObjectHelper.MapToBmp(art, map, 3, 1);
			sprites[1] = new Sprite(sprites[0], false, true);
			sprites[2].Offset(0, -8);
			sprites[3].Offset(0, -8);

			properties[0] = new PropertySpec("Speed", typeof(decimal), "Extended",
				"The speed with which the spike ball is launched.", null, 
				(obj) => obj.SubType / 16m,
				(obj, value) => obj.SubType = (byte)((decimal)value * 16m));
		}
	}
}

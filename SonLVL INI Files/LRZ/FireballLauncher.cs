using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class FireballLauncher : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite image;

		public override string Name
		{
			get { return "Fireball Launcher"; }
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
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 4, obj.Y - 16, 8, 32);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Fireball Launcher.asm", version);
			var art = LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis);

			var flame = ObjectHelper.MapToBmp(art, map, 0, 0);
			image = ObjectHelper.MapToBmp(art, map, 2, 3);
			flame.Offset(48, 0);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(new Sprite(image, flame));

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait between shots.", null,
				(obj) => obj.SubType << 2,
				(obj, value) => obj.SubType = (byte)((int)value >> 2));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class MissileLauncher : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite extraSprite;

		public override string Name
		{
			get { return "Rocket Launcher"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var sprite = this.sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			return (obj.SubType & 0x80) == 0 ? sprite : new Sprite(sprite, extraSprite);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprite[0].Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Outdoors.bin", CompressionType.Nemesis)), -2240);

			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Missile Launcher.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[4];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 1, true));

			extraSprite = ObjectHelper.MapToBmp(art, map, 6, 2, true);
			extraSprite.Offset(48, -48);

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait between launches.", null,
				(obj) => ((obj.SubType & 0x0C) + 4) << 2,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF3) | ((((int)value >> 2) - 4) & 0x0C)));

			properties[1] = new PropertySpec("Count", typeof(int), "Extended",
				"How many rockets the object will launch before pausing.", null,
				(obj) => (obj.SubType & 0x03) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFC) | (((int)value - 1) & 0x03)));

			properties[2] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's on/off cycle.", null,
				(obj) => obj.SubType & 0x70,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((int)value & 0x70)));

			properties[3] = new PropertySpec("Floor", typeof(bool), "Extended",
				"If set, a breakable floor will appear beside the object.", null,
				(obj) => (obj.SubType & 0x80) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class Flamethrower : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		public override string Name
		{
			get { return "Flamethrower"; }
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
			return sprites[subtype < 0x80 ? 0 : 1];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var single = (obj.SubType & 0x40) != 0;
			var flames = single ? new Sprite(sprites[2], obj.XFlip, false)
				: new Sprite(new Sprite(sprites[2], true, false), sprites[2]);

			return new Sprite(SubtypeImage(obj.SubType), flames);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = SubtypeImage(obj.SubType).Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -5248);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Flamethrower.asm", LevelData.Game.MappingsVersion);

			var middle = ObjectHelper.MapToBmp(art, map, 17, 0);
			var image1 = new Sprite(ObjectHelper.MapToBmp(art, map, 1, 0), middle);
			var image2 = new Sprite(ObjectHelper.MapToBmp(art, map, 3, 0), middle);
			var flames = ObjectHelper.MapToBmp(art, map, 4, 0);

			foreach (var index in new[] { 6, 11, 12 })
			{
				flames.Offset(16, 0);
				flames = new Sprite(ObjectHelper.MapToBmp(art, map, index, 0), flames);
			}

			flames.Offset(20, -4);
			flames = new Sprite(ObjectHelper.MapToBmp(art, map, 0, 0), flames);
			flames.Offset(8, 0);

			sprites = new[] { image1, image2, flames };
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[2];

			properties[0] = new PropertySpec("Spring", typeof(int), "Extended",
				"The properties of the spring on top of the object.", null, new Dictionary<string, int>
				{
					{ "None", 0x80 },
					{ "Red", 0 },
					{ "Red (twirl)", 1 },
					{ "Yellow", 2 },
					{ "Yellow (twirl)", 3 }
				},
				(obj) => obj.SubType < 0x80 ? obj.SubType & 3 : 0x80, 
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7C) | (int)value));

			properties[1] = new PropertySpec("Single", typeof(bool), "Extended",
				"If set, the object will only have a single, static nozzle.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));
		}
	}
}

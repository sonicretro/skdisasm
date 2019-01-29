using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class CupElevatorPole : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Cup Elevator Pole"; }
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
			var length = (subtype & 0x3F) == 0;
			return sprites[length ? 0 : 1][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var length = (obj.SubType & 0x3F) == 0;
			return sprites[length ? 0 : 1][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -2368);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/LBZ/Misc Object Data/Map - Cup Elevator.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 3, 2)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 4, 2))
			};

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"The object's appearance.", null, new Dictionary<string, int>
				{
					{ "Short", 0 },
					{ "Long", 1 }
				},
				(obj) => (obj.SubType & 0x3F) == 0 ? 0 : 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xC0) | ((int)value & 0x3F)));

			properties[1] = new PropertySpec("Sonic only", typeof(bool), "Extended",
				"If set, the object disappears when playing as Knuckles.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));
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

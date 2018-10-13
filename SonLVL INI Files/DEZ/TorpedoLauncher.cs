using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class TorpedoLauncher : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Torpedo Launcher"; }
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
			return sprite[obj.XFlip ? 1 : 0];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -1216);

			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/DEZ/Misc Object Data/Map - Torpedo Launcher.asm", 0, 0));

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait between launches.", null,
				(obj) => obj.SubType << 2,
				(obj, value) => obj.SubType = (byte)((int)value >> 2));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, true, false) };
		}
	}
}

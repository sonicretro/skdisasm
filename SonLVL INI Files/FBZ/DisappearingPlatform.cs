using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class DisappearingPlatform : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Disappearing Platform"; }
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
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -2080);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/FBZ/Misc Object Data/Map - Disappearing Platform.asm", 0, 1));

			properties[0] = new PropertySpec("On Period", typeof(int), "Extended",
				"How long the object remains solid for, in frames.", null, new Dictionary<string, int>
				{
					{ "60", 0x3C },
					{ "120", 0x78 },
					{ "180", 0xB4 },
					{ "240", 0xF0 },
				},
				(obj) => ((obj.SubType & 3) + 1) * 60,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFC) | ((((int)value / 60) - 1) & 3)));

			properties[1] = new PropertySpec("Period", typeof(int), "Extended",
				"How duration of the object's on/off cycle, in frames.", null, new Dictionary<string, int>
				{
					{ "128", 0x80 },
					{ "256", 0x100 },
					{ "512", 0x200 },
					{ "1024", 0x400 },
				},
				(obj) => 1 << (((obj.SubType & 0x0C) >> 2) + 7),
				(obj, value) =>
				{
					var log = (int)Math.Log((int)value, 2);
					obj.SubType = (byte)((obj.SubType & 0xF3) | (((log - 7) << 2) & 0x0C));
				});

			properties[2] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's on/off cycle.", null,
				(obj) => (1 << (((obj.SubType & 0x0C) >> 2) + 3)) * (obj.SubType >> 4),
				(obj, value) =>
				{
					var div = 1 << (((obj.SubType & 0x0C) >> 2) + 3);
					obj.SubType = (byte)((obj.SubType & 0x0F) | (((int)value / div) << 4));
				});
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

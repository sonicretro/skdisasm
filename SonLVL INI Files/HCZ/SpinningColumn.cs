using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class SpinningColumn : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Spinning Column"; }
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
			var index = (obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0);
			var sprite = this.sprite[index];

			var movement = obj.SubType & 0x03;
			switch (movement)
			{
				case 1:
					var offset = (obj.SubType & 0xF0) - 0x70;
					if (obj.XFlip) offset = -offset;

					if (offset != 0)
						return new Sprite(sprite, offset, 0);
					break;
				case 2:
					if (obj.XFlip)
						return new Sprite(sprite, 0, 0x80);
					break;
				case 3:
					return unknownSprite[index];
			}

			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var movement = obj.SubType & 0x03;
			switch (movement)
			{
				case 1:
					var length = (obj.SubType & 0xF0) > 0xE0 ? 0x100E0 : 0xE0;
					var horz = new BitmapBits(length, 1);
					horz.DrawLine(LevelData.ColorWhite, 0, 0, length, 0);
					return new Sprite(horz, -0x70, 0);
				case 2:
					var vert = new BitmapBits(1, 0x80);
					vert.DrawLine(LevelData.ColorWhite, 0, 0, 0, 0x80);
					return new Sprite(vert, 0, 0);
			}

			return null;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/HCZ/Nemesis Art/Act 2 Block Platform.bin", CompressionType.Nemesis)), -768);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/HCZ/Misc Object Data/Map - Spinning Column.asm", 1, 2));

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "None", 0x00 },
					{ "Horizontal", 0x01 },
					{ "Vertical", 0x02 }
				},
				(obj) => obj.SubType & 0x03,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFC) | ((int)value & 0x03)));

			properties[1] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point for the horizontal movement pattern.", null,
				(obj) => (obj.SubType & 0xF0) >> 4,
				(obj, value) =>
				{
					var c = (int)value << 4;
					obj.SubType = (byte)((obj.SubType & 0x0F) | (c > 0xE0 ? 0xE0 : c < 0 ? 0 : c));
				});
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

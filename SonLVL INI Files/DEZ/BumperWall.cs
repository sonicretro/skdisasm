using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class BumperWall : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] unknownSprite;
		private Sprite emptySprite;

		public override string Name
		{
			get { return "Bumper Wall"; }
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
			if (obj.SubType != 0 && obj.SubType < 0x80) return emptySprite; 
			return sprite[obj.XFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType != 0 && obj.SubType < 0x80)
			{
				var sprite = unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
				var height = obj.SubType << 1;
				if (height < 16) return sprite;

				var bitmap = new BitmapBits(16, height);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 15, height - 1);
				bitmap.DrawSprite(sprite, 8, obj.SubType);
				return new Sprite(bitmap, -8, -obj.SubType);
			}

			return null;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType != 0 && obj.SubType < 0x80)
			{
				var height = obj.SubType << 1;
				if (height < 16) return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

				return new Rectangle(obj.X - 8, obj.Y - obj.SubType, 16, height);
			}

			var bounds = sprite[0].Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Miniboss.bin", CompressionType.Nemesis)), -1568);
			var sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/DEZ/Misc Object Data/Map - Bumper Wall.asm", 0, 1);

			this.sprite = new[] { sprite, new Sprite(sprite, true, false) };
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			emptySprite = new Sprite();

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"The object's collision size.", null,
				(obj) => obj.SubType != 0 && obj.SubType < 0x80 ? obj.SubType << 1 : 64,
				(obj, value) =>
				{
					if (obj.SubType != 0 && obj.SubType < 0x80)
					{
						var height = (int)value >> 1;
						obj.SubType = (byte)(height > 0 ? height < 0x80 ? height : 0x7F : 1);
					}
				});

			properties[1] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The object's appearance.", null, new Dictionary<string, int>
				{
					{ "Normal", 0x00 },
					{ "Gravity Puzzle", 0x80 },
					{ "Invisible", 0x20 }
				},
				(obj) => obj.SubType < 0x80 ? obj.SubType == 0 ? 0x00 : 0x20 : 0x80,
				(obj, value) => obj.SubType = (byte)(int)value);
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

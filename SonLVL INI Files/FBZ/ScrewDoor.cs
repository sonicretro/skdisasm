using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class ScrewDoor : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Screw Door"; }
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
			var index = GetSpriteIndex(subtype);
			return sprites[index][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var index = GetSpriteIndex(obj.SubType);
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			int width = 16, height = 16, xoffset = 0, yoffset = 0;
			var reverse = (obj.SubType & 0x10) != 0;
			var index = GetSpriteIndex(obj.SubType);

			if (index == 0)
			{
				height = 64;
				yoffset = reverse ? -height : height;
			}
			else
			{
				width = index == 2 ? 128 : 64;
				xoffset = reverse ? -width : width;
			}

			var bitmap = new BitmapBits(width, height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, width - 1, height - 1);
			return new Sprite(bitmap, xoffset - width / 2, yoffset - height / 2);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", CompressionType.Nemesis)), -2848);
			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(
				"../Levels/FBZ/Misc Object Data/Map - Screw Door.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[3][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index << 2, 1));

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag set by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's appearance and movement pattern.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x00 },
					{ "Horizontal (64px)", 0x20 },
					{ "Horizontal (128px)", 0x40 },
					{ "Vertical (player trigger)", 0x80 }
				},
				(obj) =>
				{
					if ((obj.SubType & 0x80) != 0) return 0x80; 
					var direction = obj.SubType & 0xE0;
					return direction == 0x60 ? 0x20 : direction;
				},
				(obj, value) =>
				{
					var direction = (int)value;
					obj.SubType &= (byte)(direction == 0x80 ? 0x0F : 0x1F);
					obj.SubType = (byte)(obj.SubType | (direction & 0xE0));
				});

			properties[2] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will retract in the opposite direction.", null,
				(obj) => (obj.SubType & 0x10) != 0,
				(obj, value) =>
				{
					var reverse = (bool)value && (obj.SubType & 0x80) == 0 ? 0x10 : 0;
					obj.SubType = (byte)((obj.SubType & 0xEF) | reverse);
				});
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private int GetSpriteIndex(byte subtype)
		{
			if ((subtype & 0x20) != 0) return 1;
			if ((subtype & 0x40) != 0) return 2;
			return 0;
		}
	}
}

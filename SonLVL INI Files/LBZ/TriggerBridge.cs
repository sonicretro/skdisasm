using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class TriggerBridge : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprites;

		private Sprite[] unknownSprite;
		private int[] spriteData;

		public override string Name
		{
			get { return "Trigger Bridge"; }
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
			var index = (obj.SubType & 0xB0) >> 2;
			if (index > spriteData.Length)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var xoffset = (sbyte)spriteData[index++];
			var yoffset = (sbyte)spriteData[index++];
			return new Sprite(sprites[spriteData[index] >> 6], xoffset, yoffset);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = (obj.SubType & 0xB0 ^ 0x10) >> 2;
			if (index > spriteData.Length) return null;

			var xoffset = (sbyte)spriteData[index++];
			var yoffset = (sbyte)spriteData[index++];
			var xradius = spriteData[index++];
			var yradius = spriteData[index++];

			var overlay = new BitmapBits(xradius << 1, yradius << 1);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, overlay.Width - 1, overlay.Height - 1);
			return new Sprite(overlay, xoffset - xradius, yoffset - yradius);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/LBZ/Misc Object Data/Map - Trigger Bridge.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new[]
			{
				ObjectHelper.MapToBmp(art, map, 0, 2),
				ObjectHelper.MapToBmp(art, map, 8, 2)
			};

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			spriteData = new[]
			{
				0x48, 0, 8, 0x40,
				0, 0x48, 0x40, 8,
				0xB8, 0, 8, 0x40,
				0, 0x48, 0x40, 8
			};

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag monitored by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's appearance and movement pattern.", null, new Dictionary<string, int>
				{
					{ "Vertical to left", 0x00 },
					{ "Left to vertical", 0x10 },
					{ "Vertical to right", 0x20 },
					{ "Right to vertical", 0x30 }
				},
				(obj) => obj.SubType & 0xB0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((int)value & 0xB0)));
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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CNZ
{
	class Cylinder : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Barrel"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;

			if (routine > 0x0C)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			else if (routine == 0x09)
				return new Sprite(sprite, -32, -32);
			else if (routine == 0x0A)
				return new Sprite(sprite, 32, -32);
			else if (routine == 0x0B)
				return new Sprite(sprite, 32, 32);
			else if (routine == 0x0C)
				return new Sprite(sprite, -32, 32);

			else if (routine == 0x00 || obj.SubType < 0x10)
				return sprite;
			else if (routine > 0x04)
			{
				var yoffset = (routine - 4) * 32;
				if (!obj.XFlip) yoffset = -yoffset;
				return new Sprite(sprite, 0, yoffset);
			}
			else
			{
				var xoffset = routine * 32;
				if (!obj.XFlip) xoffset = -xoffset;
				return new Sprite(sprite, xoffset, 0);
			}
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			var height = 0;

			if (routine == 0x00)
				height = ((obj.SubType & 0x70) + 0x10) << 3;

			else if (routine > 0x0C || obj.SubType < 0x10)
				return null;
			else if (routine > 0x08)
			{
				var square = new BitmapBits(65, 65);
				square.DrawRectangle(LevelData.ColorWhite, 0, 0, 64, 64);
				return new Sprite(square, -32, -32);
			}
			else if (routine > 0x04)
				height = (routine - 4) * 64;
			else
			{
				var width = routine * 64;
				var horz = new BitmapBits(width + 1, 1);
				horz.DrawLine(LevelData.ColorWhite, 0, 0, width, 0);
				return new Sprite(horz, -width / 2, 0);
			}

			var vert = new BitmapBits(1, height + 1);
			vert.DrawLine(LevelData.ColorWhite, 0, 0, 0, height);
			return new Sprite(vert, 0, -height / 2);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -1952);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/CNZ/Misc Object Data/Map - Cylinder.asm", 0, 2);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "Player input", 0x00 },
					{ "Horizontal (64px)", 0x01 },
					{ "Horizontal (128px)", 0x02 },
					{ "Horizontal (192px)", 0x03 },
					{ "Horizontal (256px)", 0x04 },
					{ "Vertical (64px)", 0x05 },
					{ "Vertical (128px)", 0x06 },
					{ "Vertical (192px)", 0x07 },
					{ "Vertical (256px)", 0x08 },
					{ "Square (upper left)", 0x09 },
					{ "Square (upper right)", 0x0A },
					{ "Square (lower right)", 0x0B },
					{ "Square (lower left)", 0x0C }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Speed", typeof(int), "Extended",
				"The speed and direction of the object's movement.", null,
				(obj) =>
				{
					int routine = obj.SubType & 0x0F, speed = obj.SubType >> 4;
					return routine == 0 ? (speed & 7) + 1 : obj.XFlip ? -speed : speed;
				},
				(obj, value) =>
				{
					int routine = obj.SubType & 0x0F, speed = (int)value;
					obj.XFlip = routine != 0 && speed < 0;
					obj.SubType = (byte)(routine |
						((routine == 0 ? (speed - 1) & 7 : speed < 0 ? -speed : speed) << 4));
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

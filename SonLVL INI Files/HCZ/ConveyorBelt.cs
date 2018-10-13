using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class ConveyorBelt : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private int[] conveyorData;

		public override string Name
		{
			get { return "Conveyor Belt Control"; }
		}

		public override bool Debug
		{
			get { return true; }
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

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = (obj.SubType & 0x0F) * 2;

			if (obj.XFlip)
			{
				var length = obj.X - conveyorData[index];
				if (length > 0)
				{
					var overlay = new BitmapBits(length, 1);
					overlay.DrawLine(LevelData.ColorWhite, 0, 0, length, 0);
					return new Sprite(overlay, -length, 0);
				}
				else
				{
					var overlay = new BitmapBits(22, 43);
					overlay.DrawCircle(LevelData.ColorWhite, 21, 21, 21);
					return new Sprite(overlay, -21, -42);
				}
			}
			else
			{
				var length = conveyorData[index + 1] - obj.X;
				if (length > 0)
				{
					var overlay = new BitmapBits(length, 1);
					overlay.DrawLine(LevelData.ColorWhite, 0, 0, length, 0);
					return new Sprite(overlay, 0, 0);
				}
				else
				{
					var overlay = new BitmapBits(22, 43);
					overlay.DrawCircle(LevelData.ColorWhite, 0, 21, 21);
					return new Sprite(overlay, 0, 0);
				}
			}
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[1];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			conveyorData = new[]
			{
				0xB28, 0xCD8,
				0xBA8, 0xCD8,
				0xBA8, 0xCD8,
				0xEA8, 0x1058,
				0x11A8, 0x12D8,
				0x1928, 0x19D8,
				0x21A8, 0x2358,
				0x21A8, 0x2358,
				0x22A8, 0x2458,
				0x23A8, 0x2558,
				0x2528, 0x26D8,
				0x26A8, 0x27D8,
				0x26A8, 0x2958,
				0x2728, 0x28D8,
				0x3328, 0x3458,
				0x3328, 0x33D8
			};

			properties[0] = new PropertySpec("Belt ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
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

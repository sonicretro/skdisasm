using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class InvisibleShockBlock : InvisibleBlock
	{
		public override string Name
		{
			get { return "Invisible Shock Block"; }
		}
	}

	class InvisibleLavaBlock : InvisibleBlock
	{
		public override string Name
		{
			get { return "Invisible Lava Block"; }
		}
	}

	class InvisibleHurtBlockHorizontal : InvisibleBlock
	{
		public override string Name
		{
			get { return "Invisible Hurt Block (top)"; }
		}
	}

	class InvisibleHurtBlockVertical : InvisibleBlock
	{
		public override string Name
		{
			get { return "Invisible Hurt Block (sides)"; }
		}
	}

	class InvisibleBlock : ObjectDefinition
	{
		private Sprite[] img;

		public override void Init(ObjectData data)
		{
			var artfile = ObjectHelper.OpenArtFile("../General/Sprites/Ring/RingHUDText.bin", CompressionType.Nemesis);
			var sprite = ObjectHelper.MapASMToBmp(artfile, "../General/Sprites/Level Misc/Map - Invisible Block.asm", 0, 0);
			sprite.InvertPriority();

			img = new[]
			{
				sprite,
				new Sprite(sprite, true, false),
				new Sprite(sprite, false, true),
				new Sprite(sprite, true, true)
			};
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0 }); }
		}

		public override string Name
		{
			get { return "Invisible Solid Block"; }
		}

		public override string SubtypeName(byte subtype)
		{
			return ((subtype >> 4) + 1) + "x" + ((subtype & 0xF) + 1) + " blocks";
		}

		public override Sprite Image
		{
			get { return img[0]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return img[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return img[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			int w = ((obj.SubType >> 4) + 1) * 16;
			int h = ((obj.SubType & 0xF) + 1) * 16;
			BitmapBits bmp = new BitmapBits(w, h);
			bmp.DrawRectangle(LevelData.ColorWhite, 0, 0, w - 1, h - 1);
			return new Sprite(bmp, -(w / 2), -(h / 2));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			int w = ((obj.SubType >> 4) + 1) * 16;
			int h = ((obj.SubType & 0xF) + 1) * 16;
			return new Rectangle(obj.X - (w / 2), obj.Y - (h / 2), w, h);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override bool Debug { get { return true; } }

		private PropertySpec[] customProperties = new PropertySpec[] {
			new PropertySpec("Width", typeof(int), "Extended", null, null, GetWidth, SetWidth),
			new PropertySpec("Height", typeof(int), "Extended", null, null, GetHeight, SetHeight)
		};

		public override PropertySpec[] CustomProperties
		{
			get
			{
				return customProperties;
			}
		}

		private static object GetWidth(ObjectEntry obj)
		{
			return (obj.SubType & 0xF0) >> 4;
		}

		private static void SetWidth(ObjectEntry obj, object value)
		{
			obj.SubType = (byte)((Math.Min((int)value, 0xF) << 4) | (obj.SubType & 0xF));
		}

		private static object GetHeight(ObjectEntry obj)
		{
			return obj.SubType & 0xF;
		}

		private static void SetHeight(ObjectEntry obj, object value)
		{
			obj.SubType = (byte)(Math.Min((int)value, 0xF) | (obj.SubType & 0xF0));
		}
	}
}

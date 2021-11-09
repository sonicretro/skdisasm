using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class TensionBridge : Common.TensionBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(
				"../Levels/HCZ/Nemesis Art/Act 2 Block Platform.bin", -512,
				"../Levels/Misc/Map - Tension Bridge.asm", 2, false, null, null, 0);
		}
	}
}

namespace S3KObjectDefinitions.ICZ
{
	class TensionBridge : Common.TensionBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(
				"../Levels/ICZ/Nemesis Art/Misc Art 1.bin", 0,
				"../Levels/ICZ/Misc Object Data/Map - ICZ Tension Bridge.asm", 2, false,
				"Angled", "If set, the bridge segments will be angled diagonally.", 3);
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class TensionBridge : Common.TensionBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("LevelArt", -8800,
				"../Levels/Misc/Map - Tension Bridge.asm", 3, true, null, null, 0);
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class TensionBridge : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private int slope;
		private bool priority;

		public override string Name
		{
			get { return "Tension Bridge"; }
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

		public override byte DefaultSubtype
		{
			get { return 0x08; }
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
			var count = obj.SubType & 0x7F;

			if (count > 16)
			{
				var unknown = ObjectHelper.UnknownObject;
				unknown.Flip(obj.XFlip, obj.YFlip);
				return unknown;
			}

			var truncated = count & 0x1E;
			var horz = truncated;
			var vert = truncated;

			if (count < 8)
			{
				horz = 8;
				vert = count < 1 ? 1 : count;
			}

			var offset = (obj.SubType & 0x80) == 0 ? 0 : slope;
			var bitmap = new BitmapBits(16 * horz, 16 + offset * vert);

			var index = 0;
			while (index < count)
				bitmap.DrawSprite(sprite, 16 * index, offset * index++);
			while (index < 8)
				bitmap.DrawSprite(sprite, 16 * index++, 0);

			return new Sprite(bitmap, priority, -8 * (truncated + 1), -8);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var count = obj.SubType & 0x7F;
			if (count > 16) return base.GetBounds(obj);

			var width = 16 * count;
			var height = (obj.SubType & 0x80) == 0 ? 16 : slope * (count - 1) + 16;
			var offset = ((width / 2) & 0xF0) + 8; 
			return new Rectangle(obj.X - offset, obj.Y - 8, width, height);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		protected void BuildSpritesProperties(string artfile, int artoffset,
			string mapfile, int startpal, bool priority, string name, string description, int slope)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);
			if (artoffset != 0)
			{
				var indexer = new MultiFileIndexer<byte>();
				indexer.AddFile(new List<byte>(art), artoffset);
				art = indexer.ToArray();
			}

			sprite = ObjectHelper.MapASMToBmp(art, mapfile, 0, startpal);
			sprite.Offset(8, 8);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			this.priority = priority;
			this.slope = slope;

			properties[0] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of bridge segments in the object.", null,
				(obj) => obj.SubType & 0x7F,
				(obj, value) =>
				{
					var c = (int)value & 0x7E;
					obj.SubType = (byte)((obj.SubType & 0x80) | (c > 16 ? 16 : c < 8 ? 8 : c));
				});

			properties[1] = new PropertySpec(name ?? "Collapsing", typeof(bool), "Extended",
				description ?? "If set, 'Count' is the trigger ID that will collapse the object.", null,
				(obj) => (obj.SubType & 0x80) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
		}
	}
}

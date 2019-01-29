using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class Door : Common.Door
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesSubtypes("../Levels/HCZ/Nemesis Art/Misc Art.bin", -320, 0, -1, 2);
		}
	}
}

namespace S3KObjectDefinitions.CNZ
{
	class Door : Common.Door
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesSubtypes("../Levels/CNZ/Nemesis Art/Misc Art.bin", -6304, 1, 0, 2);
		}
	}
}

namespace S3KObjectDefinitions.DEZ
{
	class Door : Common.Door
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesSubtypes("../Levels/DEZ/Nemesis Art/Misc Art.bin", -960, 2, -1, 1);
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class Door : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private IDictionary<byte, string> subtypeNames;
		private Sprite[][] sprites;

		private byte verticalSubtype;
		private byte horizontalSubtype;

		public override string Name
		{
			get { return "Door"; }
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

		public override byte DefaultSubtype
		{
			get { return verticalSubtype; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype];
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
			var index = GetSpriteIndex(obj.SubType);
			if (index == 2) return null;

			var sprite = sprites[index][0];
			var bitmap = new BitmapBits(sprite.Width, sprite.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, sprite.Width - 1, sprite.Height - 1);

			var xoffset = index == 0 ? 0 : obj.XFlip ? -64 : 64;
			var yoffset = index == 0 ? -64 : 0;
			return new Sprite(bitmap, sprite.X + xoffset, sprite.Y + yoffset);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 6;
		}

		protected void BuildSpritesSubtypes(string artfile, int artoffset, int vertframe, int horzframe, int startpal)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(artfile, CompressionType.Nemesis)), artoffset);
			var art = indexer.ToArray();

			subtypeNames = new Dictionary<byte, string>
			{
				{ 0x00, "Hydrocity (vertical)" },
				{ 0x01, "Carnival Night (vertical)" },
				{ 0x02, "Death Egg (vertical)" },
				{ 0x80, "Carnival Night (horizontal)" }
			};

			subtypes = new ReadOnlyCollection<byte>(new List<byte>(subtypeNames.Keys));
			verticalSubtype = (byte)vertframe;

			if (horzframe < 0)
			{
				horizontalSubtype = verticalSubtype;
				properties = new PropertySpec[0];
				sprites = new Sprite[3][];
			}
			else
			{
				horizontalSubtype = (byte)(horzframe | 0x80);
				properties = new PropertySpec[1];
				properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
					"The object's orientation.", null, new Dictionary<string, int>
					{
						{ "Vertical", verticalSubtype },
						{ "Horizontal", horizontalSubtype }
					},
					(obj) => (int)(obj.SubType < 0x80 ? verticalSubtype : horizontalSubtype),
					(obj, value) => obj.SubType = (byte)(int)value);

				sprites = new Sprite[3][];
				sprites[1] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
					"../Levels/CNZ/Misc Object Data/Map - Door Horizontal.asm", horzframe, startpal));
			}

			sprites[2] = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprites[0] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../Levels/HCZ/Misc Object Data/Map - (&CNZ &DEZ) Door.asm", vertframe, startpal));
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
			if (subtype == verticalSubtype) return 0;
			if (subtype == horizontalSubtype) return 1;
			return 2;
		}
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class CorkFloor : Common.CorkFloor
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/AIZ/Misc Object Data/Map - Cork Floor.asm");
		}
	}

	class CorkFloor2 : Common.CorkFloor
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/AIZ/Misc Object Data/Map - Cork Floor 2.asm");
		}
	}
}

namespace S3KObjectDefinitions.CNZ
{
	class CorkFloor : Common.CorkFloor
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/CNZ/Misc Object Data/Map - Cork Floor.asm",
				"../Levels/CNZ/Nemesis Art/Platform.bin", 0, 2);
		}
	}
}

namespace S3KObjectDefinitions.FBZ
{
	class CorkFloor : Common.CorkFloor
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/FBZ/Misc Object Data/Map - Cork Floor.asm",
				"../Levels/FBZ/Nemesis Art/Misc Art 1.bin", -6176, 1);
		}
	}
}

namespace S3KObjectDefinitions.LBZ
{
	class CorkFloor : Common.CorkFloor
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LBZ/Misc Object Data/Map - Cork Floor.asm");
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class CorkFloor : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[] sprite;

		public override string Name
		{
			get { return "Cork Floor"; }
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

		protected void BuildSpritesProperties(string mapfile)
		{
			BuildSpritesProperties(mapfile, "LevelArt", -32, 2);
		}
		protected void BuildSpritesProperties(string mapfile, string artfile, int offset, int startpal)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);

			if (offset != 0)
			{
				var indexer = new MultiFileIndexer<byte>();
				indexer.AddFile(new List<byte>(art), offset);
				art = indexer.ToArray();
			}

			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art, mapfile, 0, startpal));
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];

			properties[0] = new PropertySpec("Direction", typeof(int), "Extended",
				"The direction from which the object can be broken.", null, new Dictionary<string, int>
				{
					{ "Bottom", 0 },
					{ "Top", 1 }
				},
				(obj) => obj.SubType == 0 ? 0 : 1,
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

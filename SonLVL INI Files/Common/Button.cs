using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class Button : Common.Button
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/HCZ/Nemesis Art/Button.bin",
				"../General/Sprites/Buttons/Map - Button 2.asm", null, 1);
		}
	}
}

namespace S3KObjectDefinitions.CNZ
{
	class Button : Common.Button
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/CNZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -6432);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/CNZ/Misc Object Data/Map - Button.asm", null, 2);
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class ButtonHorizontal : Common.Button
	{
		public override string Name
		{
			get { return "Wall Button"; }
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Misc Art.bin",
				"../Levels/LRZ/Misc Object Data/Map - Button Horizontal.asm", "word_42D82", 3);
		}
	}

	class ButtonHorizontal2 : ButtonHorizontal
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin",
				"../Levels/LRZ/Misc Object Data/Map - Button Horizontal.asm", "word_42DA2", 1);
		}
	}

	class Button : Common.Button
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Nemesis Art/Misc Art.bin",
				"../Levels/LRZ/Misc Object Data/Map - Button.asm", null, 3);
		}
	}

	class Button2 : Common.Button
	{
		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis)), -896);

			BuildSpritesProperties(indexer.ToArray(),
				"../Levels/LRZ/Misc Object Data/Map - Button.asm", null, 1);
		}
	}
}

namespace S3KObjectDefinitions.DPZ
{
	class Button2P : Common.Button
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/DPZ/Nemesis Art/Misc Art.bin",
				"../Levels/DPZ/Misc Object Data/Map - Button.asm", "word_36354", 2);

			properties = new[] { properties[0] };
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	class Button2P : Common.Button
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../General/2P Zone/Nemesis Art/Misc Art 1.bin",
				"../General/2P Zone/Map - 2P Button.asm", null, 0);

			properties = new[] { properties[0], properties[3] };
		}
	}

	class Button : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[] sprite;

		public override string Name
		{
			get { return "Button"; }
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
			return sprite[obj.XFlip ? 1 : 0];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../General/Sprites/Buttons/Gray Button.bin",
				"../General/Sprites/Buttons/Map - Button.asm", null, 0);
		}

		protected void BuildSpritesProperties(string artfile, string mapfile, string label, int startpal)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);
			BuildSpritesProperties(art, mapfile, label, startpal);
		}

		protected void BuildSpritesProperties(byte[] art, string mapfile, string label, int startpal)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);

			if (label == null)
			{
				var sprite = ObjectHelper.MapASMToBmp(art, mapfile, 0, startpal);
				this.sprite = new[] { sprite, sprite };
				properties = new PropertySpec[4];

				properties[3] = new PropertySpec("Collision", typeof(int), "Extended",
					"The object's collision type.", null, new Dictionary<string, int>
					{
						{ "Solid", 0x00 },
						{ "Top only", 0x20 }
					},
					(obj) => obj.SubType & 0x20,
					(obj, value) => obj.SubType = (byte)((obj.SubType & 0xDF) | ((int)value & 0x20)));

				sprite.Offset(0, 4);
			}
			else
			{
				var sprite = ObjectHelper.MapASMToBmp(art, mapfile, label, startpal);
				this.sprite = new[] { sprite, new Sprite(sprite, true, false) };
				properties = new PropertySpec[3];
			}

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag set by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Trigger type", typeof(int), "Extended",
				"The bit in the trigger array flag set by this object.", null, new Dictionary<string, int>
				{
					{ "Normal", 0x00 },
					{ "Sign bit", 0x40 }
				},
				(obj) => obj.SubType & 0x40,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((int)value & 0x40)));

			properties[2] = new PropertySpec("Permanent", typeof(bool), "Extended",
				"Whether the flag remains set upon releasing the button.", null,
				(obj) => (obj.SubType & 0x10) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xEF) | ((bool)value ? 0x10 : 0)));
		}
	}
}

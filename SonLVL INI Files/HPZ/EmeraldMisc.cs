using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HPZMini
{
	class Teleporter : HPZ.EmeraldMisc
	{
		private Sprite sprite;
		private Sprite childSprite;

		public override string Name
		{
			get { return "Teleporter"; }
		}

		public override Sprite Image
		{
			get { return sprite; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(sprite, new Sprite(childSprite, -obj.X, -obj.Y));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = sprite.Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);

			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Teleporter/Teleporter.bin", CompressionType.KosinskiM),
				"../General/Sprites/Teleporter/Map - Teleporter.asm", 10, 4);

			var emeralds = BuildEmeraldSprites(7);

			emeralds[0].Offset(0x1640, 0x368);
			emeralds[1].Offset(0x15E0, 0x3A0);
			emeralds[2].Offset(0x16A0, 0x3A0);
			emeralds[3].Offset(0x15A0, 0x350);
			emeralds[4].Offset(0x16E0, 0x350);
			emeralds[5].Offset(0x1550, 0x390);
			emeralds[6].Offset(0x1730, 0x390);
			emeralds[7].Offset(0x1640, 0x340);

			childSprite = new Sprite(emeralds);
			sprite.Offset(0, 27);
		}
	}

	class MasterEmerald : HPZ.MasterEmerald
	{
		public override void Init(ObjectData data)
		{
			BuildMasterEmeraldSprites(7);
		}
	}
}

namespace S3KObjectDefinitions.HPZ
{
	class MasterEmerald : EmeraldMisc
	{
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Master Emerald"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override void Init(ObjectData data)
		{
			BuildMasterEmeraldSprites(5);
		}

		protected void BuildMasterEmeraldSprites(int startpal)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);

			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/HPZ/Nemesis Art/Emerald Misc Art.bin", CompressionType.Nemesis),
				"../Levels/HPZ/Misc Object Data/Map - Emerald Misc Art.asm", 11, startpal));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}

	class SuperEmerald : EmeraldMisc
	{
		private string[] subtypeNames;
		private Sprite[][] sprites;
		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Super Emerald"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return obj.SubType == 1 || obj.SubType == 2 ? 1 : 4;
		}

		public override void Init(ObjectData data)
		{
			subtypeNames = new[]
			{
				"Green",
				"Orange",
				"Purple",
				"Blue",
				"Silver",
				"Red",
				"Aqua",
			};

			sprites = new Sprite[subtypeNames.Length][];
			var subtypes = new byte[subtypeNames.Length];
			var emeralds = BuildEmeraldSprites(5);

			for (var index = 0; index < sprites.Length; index++)
			{
				var flipped = BuildFlippedSprites(emeralds[index]);
				foreach (var sprite in flipped) sprite.Offset(0, -8);
				sprites[index] = flipped;
				subtypes[index] = (byte)index;
			}

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			this.subtypes = new ReadOnlyCollection<byte>(subtypes);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return subtype < sprites.Length ? sprites[subtype] : unknownSprite;
		}
	}

	abstract class EmeraldMisc : ObjectDefinition
	{
		protected ReadOnlyCollection<byte> subtypes;

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return null;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		protected Sprite[] BuildEmeraldSprites(int startpal)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../Levels/HPZ/Nemesis Art/Emerald Misc Art.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../Levels/HPZ/Misc Object Data/Map - Emerald Misc Art.asm", version);

			var sprites = new Sprite[8];

			sprites[0] = ObjectHelper.MapToBmp(art, map, 0, 2, true);
			sprites[1] = ObjectHelper.MapToBmp(art, map, 1, 0, true);
			sprites[2] = ObjectHelper.MapToBmp(art, map, 2, 2, true);
			sprites[3] = ObjectHelper.MapToBmp(art, map, 3, 0, true);
			sprites[4] = ObjectHelper.MapToBmp(art, map, 4, 0, true);
			sprites[5] = ObjectHelper.MapToBmp(art, map, 5, 4, true);
			sprites[6] = ObjectHelper.MapToBmp(art, map, 6, 3, true);
			sprites[7] = ObjectHelper.MapToBmp(art, map, 11, startpal);

			return sprites;
		}
	}
}

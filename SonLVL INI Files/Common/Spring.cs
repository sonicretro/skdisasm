using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.EMZ
{
	class Spring2P : Common.Spring2P
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties2P(true);
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	class Spring2P : Spring
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties2P(false);
		}

		protected void BuildSpritesProperties2P(bool priority)
		{
			BuildSpritesProperties(
				"../General/2P Zone/Nemesis Art/Misc Art 2.bin", "word_23982", "word_23920", 0,
				"../General/2P Zone/Nemesis Art/Misc Art 1.bin", "word_2394A", "word_239AC", 0,
				"../General/Sprites/Level Misc/Map - 2P Spring.asm", priority);
		}
	}

	class DiagonalSpring : Spring
	{
		public override void Init(ObjectData data)
		{
			base.Init(data);
			var art = LevelData.ReadFile(
				"../General/Sprites/Level Misc/Diagonal Spring.bin", CompressionType.Nemesis);
			sprites[6] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../General/Sprites/Level Misc/Map - Spring.asm", "word_23834", 0));
			sprites[7] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../General/Sprites/Level Misc/Map - Spring.asm", "word_2389C", 0));
			sprites[8] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../General/Sprites/Level Misc/Map - Spring.asm", "word_23882", 0));
			sprites[9] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(art,
				"../General/Sprites/Level Misc/Map - Spring.asm", "word_238EA", 0));
		}
	}

	class RetractingSpring : Spring
	{
		public override string Name
		{
			get { return "Retracting Spring"; }
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var direction = obj.SubType & 0x70;
			if (direction > 0x40) return null;

			if (direction == 0x10)
			{
				var horz = new BitmapBits(8, 32);
				horz.DrawRectangle(LevelData.ColorWhite, 0, 0, 7, 31);
				return new Sprite(horz, obj.XFlip ? 24 : 32, -16);
			}
			if (direction < 0x30)
			{
				var vert = new BitmapBits(32, 8);
				vert.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 7);
				return new Sprite(vert, -16, obj.YFlip ? 32 : 24);
			}

			var diag = new BitmapBits(28, 28);
			diag.DrawLine(LevelData.ColorWhite, 0, 4, 4, 0);
			diag.DrawLine(LevelData.ColorWhite, 5, 0, 27, 22);
			diag.DrawLine(LevelData.ColorWhite, 0, 5, 22, 27);
			diag.DrawLine(LevelData.ColorWhite, 23, 27, 27, 23);
			var overlay = new Sprite(diag, -16, -16);

			overlay.Flip(obj.XFlip, obj.YFlip ^ direction == 0x40);
			overlay.Offset(obj.XFlip ^ direction == 0x40 ? 32 : -32, 32);
			return overlay;
		}
	}

	class Spring : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[][] sprites;

		public override string Name
		{
			get { return "Spring"; }
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
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(
				"../General/Sprites/Level Misc/SpikesSprings.bin", "word_23788", "word_237AC", -512,
				"../General/Sprites/Level Misc/SpikesSprings.bin", "word_237D0", "word_237F4", -1024,
				"../General/Sprites/Level Misc/Map - Spring.asm", false);
		}

		protected void BuildSpritesProperties(
			string vertartfile, string vertred, string vertyel, int vertoffset,
			string horzartfile, string horzred, string horzyel, int horzoffset, string mapfile, bool priority)
		{
			var vertart = LevelData.ReadFile(vertartfile, CompressionType.Nemesis);
			var horzart = LevelData.ReadFile(horzartfile, CompressionType.Nemesis);

			if (vertoffset != 0)
			{
				var indexer = new MultiFileIndexer<byte>();
				indexer.AddFile(new List<byte>(vertart), vertoffset);
				vertart = indexer.ToArray();
			}

			if (horzoffset != 0)
			{
				var indexer = new MultiFileIndexer<byte>();
				indexer.AddFile(new List<byte>(horzart), horzoffset);
				horzart = indexer.ToArray();
			}

			sprites = new Sprite[16][];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[5];

			sprites[0] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(vertart, mapfile, vertred, 0, priority));
			sprites[1] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(vertart, mapfile, vertyel, 0, priority));
			sprites[2] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(horzart, mapfile, horzred, 0, priority));
			sprites[3] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(horzart, mapfile, horzyel, 0, priority));
			sprites[4] = sprites[0];
			sprites[5] = sprites[1];

			var unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			for (var index = 6; index < sprites.Length; index++)
				sprites[index] = unknownSprite;

			properties[0] = new PropertySpec("Twirl", typeof(bool), "Extended",
				"If set, the object will trigger the player's twirl animation.", null,
				(obj) => (obj.SubType & 0x01) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFE) | ((bool)value ? 0x01 : 0)));

			properties[1] = new PropertySpec("Color", typeof(int), "Extended",
				"The spring's appearance and initial force.", null, new Dictionary<string, int>
				{
					{ "Red", 0x00 },
					{ "Yellow", 0x02 }
				},
				(obj) => obj.SubType & 0x02,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFD) | ((int)value & 0x02)));

			properties[2] = new PropertySpec("Layer", typeof(int), "Extended",
				"The player's collision path after touching the object.", null, new Dictionary<string, int>
				{
					{ "No Change", 0x00 },
					{ "Layer 1", 0x04 },
					{ "Layer 2", 0x08 }
				},
				(obj) => { var index = (obj.SubType & 0x0C); return index >= 0x0C ? 0x00 : index; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF3) | ((int)value & 0x0C)));

			properties[3] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Up", 0x00 },
					{ "Horizontal", 0x10 },
					{ "Down", 0x20 },
					{ "Diagonal Up", 0x30 },
					{ "Diagonal Down", 0x40 }
				},
				(obj) => obj.SubType & 0x70,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((int)value & 0x70)));

			properties[4] = new PropertySpec("Kill Transverse Speed", typeof(bool), "Extended",
				"If set, the object will clear the player's existing momentum.", null,
				(obj) => (obj.SubType & 0x80) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[((subtype & 0x02) >> 1) | ((subtype & 0x70) >> 3)];
		}
	}
}

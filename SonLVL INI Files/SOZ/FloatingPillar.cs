using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class FloatingPillar : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Floating Pillar"; }
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
			return sprites[0][0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			var frame = obj.SubType >> 4;

			if (routine > 6 || frame >= sprites.Length)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var sprite = sprites[frame][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			var offset = (obj.XFlip ? 32 : -32) << ((routine - 1) % 3);

			if (routine > 3)
				return new Sprite(sprite, 0, -offset);
			else
				return new Sprite(sprite, offset, 0);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			var frame = obj.SubType >> 4;

			if (routine == 0 || routine > 6 || frame >= sprites.Length) return null;
			var length = 64 << ((routine - 1) % 3);
			var adjust = frame == 0 ? 0 : frame == 1 ^ obj.YFlip ? 16 : -16;

			if (routine > 3)
			{
				var offset = (obj.XFlip ? length : -length) / 2;

				var bitmap = new BitmapBits(64, 128);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 63, 127);
				return new Sprite(bitmap, -32, offset + adjust - 64);
			}
			else
			{
				var bitmap = new BitmapBits(length, 1);
				bitmap.DrawLine(LevelData.ColorWhite, 0, 0, length, 0);
				return new Sprite(bitmap, -length / 2, adjust);
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			var frame = obj.SubType >> 4;

			if (routine > 6 || frame >= sprites.Length)
				return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);

			var offset = (obj.XFlip ? 32 : -32) << ((routine - 1) % 3);
			var adjust = frame == 0 ? 0 : frame == 1 ^ obj.YFlip ? 16 : -16;

			if (routine > 3)
				return new Rectangle(obj.X - 32, obj.Y - offset + adjust - 64, 64, 128);

			return new Rectangle(obj.X + offset - 32, obj.Y + adjust - 64, 64, 128);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../General/Sprites/Level Misc/SpikesSprings.bin", CompressionType.Nemesis)), 37472);
			var art = indexer.ToArray();

			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/SOZ/Misc Object Data/Map - Floating Pillar.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[3][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 2));

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "None", 0x00 },
					{ "Horizontal (64px)", 0x01 },
					{ "Horizontal (128px)", 0x02 },
					{ "Horizontal (256px)", 0x03 },
					{ "Vertical (64px)", 0x04 },
					{ "Vertical (128px)", 0x05 },
					{ "Vertical (256px)", 0x06 }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x70) | ((int)value & 0x0F)));

			properties[1] = new PropertySpec("Spikes", typeof(int), "Extended",
				"The side of the object on which spikes should appear.", null, new Dictionary<string, int>
				{
					{ "None", 0x00 },
					{ "Top", 0x10 },
					{ "Bottom", 0x20 },
				},
				(obj) => obj.SubType & 0x70,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((int)value & 0x70)));
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

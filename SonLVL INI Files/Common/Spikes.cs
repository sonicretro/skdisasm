using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class Spikes : Common.Spikes
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(false, LevelData.ReadFile(
				"../Levels/FBZ/Animated Tiles/3.bin", CompressionType.Uncompressed));
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	class Spikes2P : Spikes
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(true, null);
		}
	}

	class Spikes : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;
		private int numRoutines;
		private int blockSize;

		public override string Name
		{
			get { return "Spikes"; }
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
			var routine = obj.SubType & 0x0F;
			var sprite = routine > numRoutines ? unknownSprite : GetSubtypeSprites(obj.SubType);
			var temp = sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			if (routine == 1 && obj.YFlip) return new Sprite(temp, 0, blockSize);
			if (routine == 2 && obj.XFlip) return new Sprite(temp, blockSize, 0);
			return temp;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			if (routine == 0 || routine > numRoutines) return null;

			if (routine == 3)
			{
				var bitmap = new BitmapBits(33, 1);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 32, 0);
				return new Sprite(bitmap);
			}
			else
			{
				var bounds = GetBounds(obj);
				var bitmap = new BitmapBits(bounds.Width, bounds.Height);
				bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);

				var xoffset = routine == 2 && !obj.XFlip ? blockSize : 0;
				var yoffset = routine == 1 && !obj.YFlip ? blockSize : 0;
				return new Sprite(bitmap, xoffset - (bounds.Width / 2), yoffset - (bounds.Height / 2));
			}
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var routine = obj.SubType & 0x0F;
			var count = ((obj.SubType & 0x30) >> 4) + 1;
			var vertical = (obj.SubType & 0xC0) < 0x40;

			var width = vertical ? blockSize * count : blockSize;
			var height = vertical ? blockSize : blockSize * count;
			var xoffset = (routine == 2 && obj.XFlip ? blockSize : 0) - width / 2;
			var yoffset = (routine == 1 && obj.YFlip ? blockSize : 0) - height / 2;
			return new Rectangle(obj.X + xoffset, obj.Y + yoffset, width, height);
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(false, null);
		}

		protected void BuildSpritesProperties(bool competition, byte[] vertart)
		{
			byte[] map, horzart;

			if (competition)
			{
				map = LevelData.ASMToBin("../General/2P Zone/Map - Spikes.asm", LevelData.Game.MappingsVersion);
				horzart = LevelData.ReadFile("../General/2P Zone/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis);
				vertart = horzart;

				numRoutines = 2;
				blockSize = 24;
			}
			else
			{
				map = LevelData.ASMToBin("../General/Sprites/Level Misc/Map - Spikes.asm", LevelData.Game.MappingsVersion);
				horzart = LevelData.ReadFile("../General/Sprites/Level Misc/SpikesSprings.bin", CompressionType.Nemesis);
				if (vertart == null)
				{
					var indexer = new MultiFileIndexer<byte>();
					indexer.AddFile(new List<byte>(horzart), -256);
					vertart = indexer.ToArray();
				}

				numRoutines = 3;
				blockSize = 32;
			}

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[8][];

			var art = new[] { vertart, vertart, vertart, vertart, horzart, horzart, horzart, horzart };
			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art[index], map, index, 0));

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "None", 0 },
					{ "Vertical", 1 },
					{ "Horizontal", 2 }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));

			if (!competition)
				properties[0].Enumeration.Add("Pushable", 3);

			properties[1] = new PropertySpec("Count", typeof(int), "Extended",
				"The number of spike blocks in the object.", null,
				(obj) => ((obj.SubType & 0x30) >> 4) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xCF) | ((((int)value - 1) << 4) & 0x30)));

			properties[2] = new PropertySpec("Direction", typeof(int), "Extended",
				"The object's orientation.", null, new Dictionary<string, int>
				{
					{ "Vertical", 0x00 },
					{ "Horizontal", 0x40 }
				},
				(obj) => obj.SubType & 0xC0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x3F) | ((int)value & 0xC0)));
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
			var index = subtype >> 4;
			return sprites[(index < 4 ? 0 : 4) + (index & 3)];
		}
	}
}

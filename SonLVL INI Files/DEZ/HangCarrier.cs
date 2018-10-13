using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class HangCarrier : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Hang Carrier"; }
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
			return sprite[obj.YFlip ? 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var ceiling = FindCeiling(obj);
			var width = obj.SubType << 3;
			var height = Math.Abs(obj.Y - 20 - ceiling);

			var bitmap = new BitmapBits(width + 1, height + 1);
			var xoffset = obj.XFlip ? width : 0;
			bitmap.DrawLine(LevelData.ColorWhite, xoffset, 0, xoffset, height);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, width, 0);

			var yflip = obj.Y - 20 < ceiling;
			var overlay = new Sprite(bitmap, -xoffset, yflip ? -height - 1 : -height);
			overlay.Flip(false, yflip);
			return overlay;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/DEZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -512);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/DEZ/Misc Object Data/Map - Hang Carrier.asm", 0, 1));

			properties[0] = new PropertySpec("Distance", typeof(int), "Extended",
				"Horizontal distance the object will travel, in pixels.", null,
				(obj) => obj.SubType << 3,
				(obj, value) => obj.SubType = (byte)((int)value >> 3));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, false, true) };
		}

		private int FindCeiling(ObjectEntry obj)
		{
			var objY = obj.Y - 4;
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = obj.X / LevelData.Level.ChunkWidth;
			var blockX = obj.X % LevelData.Level.ChunkWidth / 16;
			var solidX = obj.X % 16;

			while (true)
			{
				var chunk = LevelData.Chunks[LevelData.Layout.FGLayout[chunkX, chunkY]];
				var block = chunk.Blocks[blockX, objY % LevelData.Level.ChunkHeight / 16];
				var index = LevelData.GetColInd1(block.Block);
				var solid = LevelData.ColArr1[index][block.XFlip ? 15 - solidX : solidX];

				if (solid == 0 || (block.Solid1 & Solidity.LRBSolid) == 0)
				{
					objY = objY - 16;
					if (objY < 0) return 0;
					chunkY = objY / LevelData.Level.ChunkHeight;
				}
				else
				{
					var height = Math.Abs(index);
					var inverted = block.YFlip ^ solid < 0;
					return (objY & 0xFF0) + (inverted ? solid : 16);
				}
			}
		}
	}
}

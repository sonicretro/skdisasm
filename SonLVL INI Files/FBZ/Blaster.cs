using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class Blaster : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite overlay;

		public override string Name
		{
			get { return "Blaster"; }
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
			var sprite = this.sprite[obj.XFlip ? 1 : 0];
			if (!obj.YFlip) return sprite;

			var ceiling = FindCeiling(obj);
			if (ceiling == 0) return sprite;

			return new Sprite(sprite, 0, ceiling - obj.Y + 8);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return obj.YFlip ? overlay : null;
			var range = obj.SubType * 2;

			var bitmap = new BitmapBits(range, 1);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, range, 0);
			var line = new Sprite(bitmap, -obj.SubType, 2);
			return obj.YFlip ? new Sprite(overlay, line) : line;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = overlay.Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Blaster/Blaster.bin", CompressionType.KosinskiM),
				"../General/Sprites/Blaster/Map - Blaster.asm", 0, 1, true));

			var bitmap = new BitmapBits(32, 24);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 23);
			overlay = new Sprite(bitmap, -16, -9);

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Horizontal range patrolled by the object, in pixels.", null,
				(obj) => obj.SubType * 2,
				(obj, value) => obj.SubType = (byte)((int)value / 2));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			return new[] { sprite, new Sprite(sprite, true, false) };
		}

		private int FindCeiling(ObjectEntry obj)
		{
			var objY = obj.Y - 9;
			if (objY < 0) return 0;

			var chunkY = objY / LevelData.Level.ChunkHeight;
			if (chunkY >= LevelData.FGHeight) return 0;

			var chunkX = obj.X / LevelData.Level.ChunkWidth;
			var blockX = obj.X % LevelData.Level.ChunkWidth / 16;
			var solidX = obj.X % 16;
			var foundEmpty = false;

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
					foundEmpty = true;
				}
				else if (!foundEmpty && solid == 16)
				{
					objY = objY + 16;
					chunkY = objY / LevelData.Level.ChunkHeight;
					if (chunkY >= LevelData.FGHeight) return 0;
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

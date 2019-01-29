using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HPZ
{
	class Autoscroll : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Autoscroll"; }
		}

		public override Sprite Image
		{
			get { return unknownSprite[0]; }
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
			return unknownSprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(sprite, 0x40 - obj.X, 0x460 - obj.Y);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 8, obj.Y - 7, 16, 14);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 6;
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/KosinskiM Art/Autoscroll.bin", CompressionType.KosinskiM),
				"../Levels/LRZ/Misc Object Data/Map - Act 3 Autoscroll.asm", 0, 1);
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

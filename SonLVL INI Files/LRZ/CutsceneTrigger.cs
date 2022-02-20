using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class CutsceneTrigger : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Cutscene Trigger"; }
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
			return new Sprite(sprite, 0x3A08 - obj.X, 0xE2 - obj.Y);
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
			return 4;
		}

		public override void Init(ObjectData data)
		{
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			sprite = ObjectHelper.MapDPLCToBmp(LevelData.ReadFile(
				"../General/Sprites/Knuckles/Art/Knuckles.bin", CompressionType.Uncompressed), LevelData.ASMToBin(
				"../General/Sprites/Knuckles/Map - Knuckles.asm", EngineVersion.S3K), EngineVersion.S3K, LevelData.ASMToBin(
				"../General/Sprites/Knuckles/DPLC - Knuckles.asm", EngineVersion.S2), EngineVersion.S2, 0x56, 7, true);

			sprite.Flip(true, false);
			sprite.Offset(48, 10);
			sprite = new Sprite(sprite, ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/KosinskiM Art/Knuckles Boulder.bin", CompressionType.KosinskiM),
				"../Levels/LRZ/Misc Object Data/Map - Knuckles Boulder.asm", 0, 2));
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

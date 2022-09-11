using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class EggMobile : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;
		private Sprite childSprite;

		private Sprite image;

		public override string Name
		{
			get { return "Egg Mobile"; }
		}

		public override Sprite Image
		{
			get { return image; }
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
			return image;
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

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../General/Sprites/Robotnik/Robotnik Ship Crane.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin(
				"../General/Sprites/Robotnik/Map - Robotnik Ship Crane.asm", version);

			var claw0 = ObjectHelper.MapToBmp(art, map, 0, 0, true);
			var claw1 = ObjectHelper.MapToBmp(art, map, 1, 0, true);

			image = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Robotnik/Ship.bin", CompressionType.Nemesis),
				"../General/Sprites/Robotnik/Map - Robotnik Ship.asm", 10, 0, true);

			var head = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Robotnik/Egg Robo Head.bin", CompressionType.KosinskiM),
				"../General/Sprites/Robotnik/Map - Egg Robo Head.asm", 0, 0, true);

			var mecha = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Mecha Sonic/Mecha Sonic.bin", CompressionType.Uncompressed),
				"../General/Sprites/Mecha Sonic/Map - Mecha Sonic.asm", 0, 1, true);

			var emerald = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Ending/KosinskiM Art/Master Emerald.bin", CompressionType.KosinskiM),
				"../Levels/SSZ/Misc Object Data/Map - Master Emerald.asm", 0, 0, true);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			head.Offset(0, -28);
			claw0.Offset(0, 35);
			claw1.Offset(0, 35);
			sprite = new Sprite(head, image, claw0, claw1);

			mecha.Offset(0x220, 0x4A0);
			emerald.Offset(0x340, 0x4A8);
			childSprite = new Sprite(mecha, emerald);
		}
	}
}

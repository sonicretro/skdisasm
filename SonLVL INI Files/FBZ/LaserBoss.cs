using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.FBZ
{
	class LaserBoss : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite extraSprites;

		public override string Name
		{
			get { return "Boss"; }
		}

		public override Sprite Image
		{
			get { return sprite[0]; }
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
			return new Sprite(GetFlippedSprite(obj), extraSprites);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = GetFlippedSprite(obj).Bounds;
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
			var art = LevelData.ReadFile("../Levels/FBZ/Nemesis Art/Act 2 Subboss.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/FBZ/Misc Object Data/Map - Act 2 Subboss.asm", version);

			sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 5, true));
			foreach (var image in sprite) image.Offset(0, 28);

			var emitter1 = ObjectHelper.MapToBmp(art, map, 1, 5, true);
			emitter1.Offset(176, 168);
			var emitter2 = new Sprite(emitter1, 0, 192, false, true);
			var emitter3 = new Sprite(emitter1, true, false);
			var emitter4 = new Sprite(emitter2, true, false);

			var console = ObjectHelper.MapToBmp(art, map, 2, 5, true);
			console.Offset(204, 124);

			var beam1 = ObjectHelper.MapToBmp(art, map, 4, 5, true);
			beam1.Offset(176, 96);
			var beam2 = new Sprite(beam1, true, false);

			var eggman = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Robotnik/FBZ Robotnik Stand.bin", CompressionType.Nemesis),
				"../General/Sprites/Robotnik/Map - FBZ Robotnik Stand.asm", 0, 0, true);
			eggman.Offset(216, 116);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			extraSprites = new Sprite(emitter1, emitter2, emitter3, emitter4, beam1, beam2, eggman, console);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite GetFlippedSprite(ObjectEntry obj)
		{
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}
	}
}

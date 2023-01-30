using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SSZ
{
	class EggRobo : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Egg Robo"; }
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
			var index = (obj.SubType & 0x09) == 0 ? (obj.SubType >> 1) & 3 : 3;
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if ((obj.SubType & 6) != 4) return base.GetBounds(obj);

			var bounds = sprites[1][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)].Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../General/Sprites/Egg Robo/Egg Robo Badnik.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin(
				"../General/Sprites/Egg Robo/Map - Egg Robo Badnik.asm", LevelData.Game.MappingsVersion);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[4][];

			sprites[0] = BuildFlippedSprites(
				ReadScaledArt("../General/Sprites/Egg Robo/Egg Robo Fly Scaled.bin", 0, 1, true));

			var arm = ObjectHelper.MapToBmp(art, map, 2, 0);
			var body = ObjectHelper.MapToBmp(art, map, 3, 0, true);
			var legs = ObjectHelper.MapToBmp(art, map, 6, 0);
			arm.Offset(-28, -4);
			legs.Offset(-12, 28);

			sprites[1] = BuildFlippedSprites(new Sprite(arm, legs, body));

			body.InvertPriority();
			sprites[2] = BuildFlippedSprites(new Sprite(arm, legs, body));

			var cucky = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Animals/Chicken.bin", CompressionType.Nemesis),
				"../General/Sprites/Animals/Map - Animals 4.asm", 0, 0);
			var pocky = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Animals/Rabbit.bin", CompressionType.Nemesis),
				"../General/Sprites/Animals/Map - Animals 5.asm", 0, 0);

			pocky.Offset(32, 20);
			var right = new Sprite(cucky, pocky);
			right.Flip(true, false);
			right.Offset(80, 0);

			pocky.Offset(-64, 0);
			var left = new Sprite(cucky, pocky);
			left.Flip(true, false);
			left.Offset(-80, 0);

			sprites[2][0] = new Sprite(sprites[2][0], left);
			sprites[2][1] = new Sprite(sprites[2][1], right);
			sprites[2][2] = new Sprite(sprites[2][2], left);
			sprites[2][3] = new Sprite(sprites[2][3], right);

			sprites[3] = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Egg Robo ID", typeof(int), "Extended",
				"The object status array flag set by this object.", null,
				(obj) => obj.SubType >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((int)value << 4)));

			properties[1] = new PropertySpec("Reveal From", typeof(int), "Extended",
				"If set, the enemy will be hidden when it first spawns.", null, new Dictionary<string, int>
				{
					{ "Start", 2 },
					{ "Side (animals)", 4 },
					{ "Background", 0 }
				},
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite ReadScaledArt(string artfile, int frame, int pal, bool priority = false)
		{
			var bitmap = new BitmapBits(64, 64);
			var src = LevelData.ReadFile(artfile, CompressionType.Uncompressed);
			var dest = bitmap.Bits;
			frame <<= 12;
			pal <<= 4;

			for (var index = 0; index < dest.Length; index++)
			{
				var color = src[frame++] & 0x0F;
				dest[index] = (byte)(color == 0 ? 0 : (pal | color));
			}

			return new Sprite(bitmap, priority, -32, -32);
		}
	}
}

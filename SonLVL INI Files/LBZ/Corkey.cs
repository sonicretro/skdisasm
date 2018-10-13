using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class Corkey : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Corkey"; }
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
			return sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;
			var range = obj.SubType * 2;

			var bitmap = new BitmapBits(range, 1);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, range, 0);
			return new Sprite(bitmap, -obj.SubType, 0);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile("../General/Sprites/Corkey/Corkey.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin("../General/Sprites/Corkey/Map - Corkey.asm", LevelData.Game.MappingsVersion);
			var barrel = ObjectHelper.MapToBmp(art, map, 1, 1);
			barrel.Offset(0, 12);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(new Sprite(ObjectHelper.MapToBmp(art, map, 0, 1), barrel));

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Horizontal range patrolled by the object, in pixels.", null,
				(obj) => obj.SubType * 2,
				(obj, value) => obj.SubType = (byte)((int)value / 2));
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

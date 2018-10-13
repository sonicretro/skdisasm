using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class Skorp : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite[] tail;

		public override string Name
		{
			get { return "Skorp"; }
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
			var sprite = this.sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
			return new Sprite(sprite, tail[obj.XFlip ? 1 : 0]);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;

			var bitmap = new BitmapBits(obj.SubType, 1);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, obj.SubType, 0);
			return new Sprite(bitmap, -obj.SubType / 2, 2);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 3;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../General/Sprites/Skorp/Skorp.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin(
				"../General/Sprites/Skorp/Map - Skorp.asm", LevelData.Game.MappingsVersion);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 1));

			var segment = ObjectHelper.MapToBmp(art, map, 3, 1);
			var tail = new Sprite(
				new Sprite(segment, 8, 0),
				new Sprite(segment, 15, 1),
				new Sprite(segment, 23, 4),
				new Sprite(segment, 28, 10),
				new Sprite(segment, 31, 18),
				ObjectHelper.MapToBmp(art, map, 4, 1));

			tail.Offset(-23, -34);
			this.tail = new[] { tail, new Sprite(tail, true, false) };

			properties[0] = new PropertySpec("Range", typeof(int), "Extended",
				"Horizontal range patrolled by the object, in pixels.", null,
				(obj) => (int)obj.SubType,
				(obj, value) => obj.SubType = (byte)(int)value);
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

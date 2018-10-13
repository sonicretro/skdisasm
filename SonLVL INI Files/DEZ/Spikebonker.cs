using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class Spikebonker : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		private Sprite spike;

		public override string Name
		{
			get { return "Spikebonker"; }
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
			var spike = new Sprite(this.spike, obj.XFlip ? -12 : 12, obj.YFlip ? -20 : 20);
			return new Sprite(sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)], spike);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0) return null;

			var bitmap = new BitmapBits(obj.SubType, 1);
			bitmap.DrawLine(LevelData.ColorWhite, 0, 0, obj.SubType, 0);
			return new Sprite(bitmap, -obj.SubType / 2, obj.YFlip ? -9 : 8);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile(
				"../General/Sprites/Spikebonker/Spikebonker.bin", CompressionType.KosinskiM);
			var map = LevelData.ASMToBin(
				"../General/Sprites/Spikebonker/Map - Spikebonker.asm", version);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			properties = new PropertySpec[1];
			sprite = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 0, 1));

			spike = ObjectHelper.MapToBmp(art, map, 1, 1);

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

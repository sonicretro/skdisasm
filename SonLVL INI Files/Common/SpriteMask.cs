using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class SpriteMask : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[][] sprites;

		public override string Name
		{
			get { return "Sprite Mask"; }
		}

		public override bool Debug
		{
			get { return true; }
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
			var index = (obj.SubType & 0xF0) >> 4;
			return sprites[index][(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bounds = GetBounds(obj);
			var bitmap = new BitmapBits(bounds.Width, bounds.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);
			return new Sprite(bitmap, -bounds.Width / 2, -bounds.Height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var height = (obj.SubType & 0xF0) >> 1;
			return new Rectangle(obj.X - 32, obj.Y - (height / 2), 64, height == 0 ? 1 : height);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return obj.SubType & 0x07;
		}

		public override void Init(ObjectData data)
		{
			var map = LevelData.ASMToBin(
				"../General/Sprites/Level Misc/Map - Sprite Mask.asm", LevelData.Game.MappingsVersion);

			var art = LevelData.ReadFile("LevelArt", 0);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[16][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, index, 0));

			properties[0] = new PropertySpec("Height", typeof(int), "Extended",
				"Vertical range in which the mask is active, in pixels.", null,
				(obj) => (obj.SubType & 0xF0) >> 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x07) | (((int)value << 1) & 0xF0)));

			properties[1] = new PropertySpec("Depth", typeof(int), "Extended",
				"The sprite depth masked by this object.", null,
				(obj) => (obj.SubType & 0x07) << 7,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | (((int)value >> 7) & 0x07)));
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

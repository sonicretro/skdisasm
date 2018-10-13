using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class StartNewLevel : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Start New Level"; }
		}

		public override bool Debug
		{
			get { return true; }
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
			var bitmap = new BitmapBits(32, 256);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 31, 255);
			return new Sprite(bitmap, -16, -128);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 16, obj.Y - 128, 32, 256);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			subtypes = new ReadOnlyCollection<byte>(new byte[] { 0, 4 });

			properties[0] = new PropertySpec("Next Zone", typeof(int), "Extended",
				"The destination Zone.", null, new Dictionary<string, int>
				{
					{ "Angel Island Zone", 0x00 },
					{ "Hydrocity Zone", 0x01 },
					{ "Marble Garden Zone", 0x02 },
					{ "Carnival Night Zone", 0x03 },
					{ "Icecap Zone", 0x05 },
					{ "Launch Base Zone", 0x06 },
					{ "Mushroom Hill Zone", 0x07 },
					{ "Flying Battery Zone", 0x04 },
					{ "Sandopolis Zone", 0x08 },
					{ "Lava Reef Zone", 0x09 },
					{ "Hidden Palace Zone", 0x16 },
					{ "Sky Sanctuary Zone", 0x0A },
					{ "Death Egg Zone", 0x0B },
					{ "The Doomsday Zone", 0x0C },
					{ "Death Egg Zone Boss", 0x17 }
				},
				(obj) => obj.SubType >> 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 1) | (((int)value << 1) & 0xFE)));

			properties[1] = new PropertySpec("Next Act", typeof(int), "Extended",
				"The destination act.", null,
				(obj) => (obj.SubType & 1) + 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFE) | ((int)value == 2 ? 1 : 0)));
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

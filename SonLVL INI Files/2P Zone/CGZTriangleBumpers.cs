using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.CGZ
{
	class TriangleBumpers : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Triangle Bumpers"; }
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
			var height = (obj.SubType & 0x70) == 0 ? 0x80 : 0x100;
			var overlay = new BitmapBits(16, height);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, 15, height - 1);
			return new Sprite(overlay, -8, -height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var height = (obj.SubType & 0x70) == 0 ? 0x80 : 0x100;
			return new Rectangle(obj.X - 8, obj.Y - (height / 2), 16, height);
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[4];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Twirl", typeof(bool), "Extended",
				"If set, the object will trigger the player's twirl animation.", null, new Dictionary<string, int>
				{
					{ "None", 0x00 },
					{ "Single", 0x03 },
					{ "Three", 0x01 }
				},
				(obj) => { var index = obj.SubType & 0x03; return index == 0x02 ? 0x00 : index; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xFC) | ((int)value & 0x03)));

			properties[1] = new PropertySpec("Layer", typeof(int), "Extended",
				"The player's collision path after touching the object.", null, new Dictionary<string, int>
				{
					{ "No Change", 0x00 },
					{ "Layer 1", 0x04 },
					{ "Layer 2", 0x08 }
				},
				(obj) => { var index = obj.SubType & 0x0C; return index >= 0x0C ? 0x00 : index; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF3) | (((int)value & 0x0C) % 0x0C)));

			properties[2] = new PropertySpec("Height", typeof(int), "Extended",
				"The object's collision size.", null, new Dictionary<string, int>
				{
					{ "Short", 0 },
					{ "Long", 1 }
				},
				(obj) => (obj.SubType & 0x70) == 0x00 ? 0 : 1,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | ((int)value == 0 ? 0x00 : 0x10)));

			properties[3] = new PropertySpec("Kill Transverse Speed", typeof(bool), "Extended",
				"If set, the object will clear the player's vertical momentum.", null,
				(obj) => (obj.SubType & 0x80) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));
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

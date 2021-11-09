using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.SOZ
{
	class CapsuleArtLoadTrigger : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private string[] subtypeNames;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Capsule Art Load Trigger"; }
		}

		public override bool Debug
		{
			get { return true; }
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
			return subtypeNames[subtype >> 2];
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
			if (obj.SubType != 0 && obj.SubType != 4) return null;

			var bounds = GetBounds(obj);
			var bitmap = new BitmapBits(bounds.Width, bounds.Height);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);
			return new Sprite(bitmap, -bounds.Width / 2, -bounds.Height / 2);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			if (obj.SubType == 0) return new Rectangle(obj.X - 16, obj.Y - 64, 32, 128);
			if (obj.SubType == 4) return new Rectangle(obj.X - 16, obj.Y - 128, 32, 256);
			return base.GetBounds(obj);
		}

		public override void Init(ObjectData data)
		{
			sprite = BuildFlippedSprites(ObjectHelper.UnknownObject);
			subtypes = new ReadOnlyCollection<byte>(new byte[] { 0, 4 });
			subtypeNames = new[]
			{
				"Load Capsule Graphics",
				"Restore Enemy Graphics"
			};
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

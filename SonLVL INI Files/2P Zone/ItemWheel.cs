using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
	class ItemWheel : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;
		private Sprite image;

		public override string Name
		{
			get { return "Item Wheel"; }
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
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bitmap = new BitmapBits(113, 113);
			bitmap.DrawCircle(LevelData.ColorWhite, 56, 56, 56);
			return new Sprite(bitmap, -56, -56);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var art = LevelData.ReadFile(
				"../General/2P Zone/Nemesis Art/Misc Art 3.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin(
				"../General/2P Zone/Map - Item.asm", LevelData.Game.MappingsVersion);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			image = ObjectHelper.MapToBmp(art, map, 0, 0);
			sprite = ObjectHelper.MapToBmp(art, map, 1, 0);

			sprite.Offset(-104, 40);
			sprite = new Sprite(image, sprite);
			sprite.Offset(52, -20);
		}
	}
}

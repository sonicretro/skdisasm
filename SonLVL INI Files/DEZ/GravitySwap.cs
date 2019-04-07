using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.DEZ
{
	class GravitySwap : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Gravity Swapper"; }
		}

		public override bool Debug
		{
			get { return true; }
		}

		public override Sprite Image
		{
			get { return sprite; }
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
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return sprite;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Ring/RingHUDText.bin", CompressionType.Nemesis),
				"../General/Sprites/Level Misc/Map - Path Swap.asm", 0, 2, true);

			properties[0] = new PropertySpec("Left Gravity", typeof(int), "Extended",
				"Gravity once the player is to the left of the object.", null, new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Reverse", 1 }
				},
				(obj) => obj.XFlip ? 1 : 0,
				(obj, value) => obj.XFlip = (int)value == 1);

			properties[1] = new PropertySpec("Right Gravity", typeof(int), "Extended",
				"Gravity once the player is to the right of the object.", null, new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Reverse", 1 }
				},
				(obj) => obj.XFlip ? 0 : 1,
				(obj, value) => obj.XFlip = (int)value == 0);
		}
	}
}

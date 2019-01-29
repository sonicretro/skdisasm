using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.AIZ
{
	class FallingLog2 : FallingLog
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(
				"../Levels/AIZ/Nemesis Art/Misc Art 2.bin",
				"../Levels/AIZ/Misc Object Data/Map - Falling Log 2.asm",
				"../Levels/AIZ/Misc Object Data/Map - Falling Log Splash 2.asm", 3);
		}
	}

	class FallingLog : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		public override string Name
		{
			get { return "Falling Log"; }
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

		public override byte DefaultSubtype
		{
			get { return 6; }
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
			var distance = LevelData.Level.WaterHeight - obj.Y;
			if (distance < 0) return sprite;

			var period = 1 << ((obj.SubType & 0x0F) + 1);
			if (period > distance) return sprite;

			var sprites = new Sprite[distance / period + 1];
			sprites[0] = sprite;
			for (var index = 1; index < sprites.Length; index++)
				sprites[index] = new Sprite(sprite, 0, index * period);

			return new Sprite(sprites);
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 24, obj.Y - 8, 48, 16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			BuildSpritesProperties(
				"../Levels/AIZ/Nemesis Art/Falling Log.bin",
				"../Levels/AIZ/Misc Object Data/Map - Falling Log.asm",
				"../Levels/AIZ/Misc Object Data/Map - Falling Log Splash.asm", 2);
		}

		protected void BuildSpritesProperties(string artfile, string mapfile, string splashmap, int splashpal)
		{
			var art = LevelData.ReadFile(artfile, CompressionType.Nemesis);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = new Sprite(ObjectHelper.MapASMToBmp(art, mapfile, 0, 2),
				ObjectHelper.MapASMToBmp(art, splashmap, 0, splashpal));

			properties[0] = new PropertySpec("Delay", typeof(int), "Extended",
				"How many frames the object will wait before respawning.", null,
				(obj) => 1 << ((obj.SubType & 0x0F) + 1),
				(obj, value) =>
				{
					var log = (int)Math.Log((int)value, 2);
					obj.SubType = (byte)((obj.SubType & 0xF0) | ((log - 1) & 0x0F));
				});

			properties[1] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's spawn cycle.", null,
				(obj) =>
				{
					var offset = obj.SubType >> 4;
					var shift = (obj.SubType & 0x0F) - 3;
					return shift > 0 ? offset << shift : offset;
				},
				(obj, value) =>
				{
					var shift = (obj.SubType & 0x0F) - 3;
					var bits = shift > 0 ? (int)value >> shift : (int)value;
					obj.SubType = (byte)((obj.SubType & 0x0F) | ((bits << 4) & 0xF0));
				});
		}
	}
}

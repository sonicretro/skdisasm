using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class SolidRock : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;

		public override string Name
		{
			get { return "Rock Elevator"; }
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
			var pattern = GetMovementPattern(obj);
			return new Sprite(sprite, 0, -96 * ((pattern & 2) - 1) * ((pattern & 1) + 1));
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bitmap = new BitmapBits(48, 32);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, 47, 31);

			var pattern = GetMovementPattern(obj);
			var distance = 96 * ((pattern & 2) - 1) * ((pattern & 1) + 1);
			return new Sprite(bitmap, -24, distance - 16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -4608);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/LRZ/Misc Object Data/Map - Solid Rock.asm", 0, 2));

			properties[0] = new PropertySpec("Trigger ID", typeof(int), "Extended",
				"The level trigger array flag monitored by this object.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((int)value & 0x0F));

			properties[1] = new PropertySpec("Trigger type", typeof(int), "Extended",
				"The bit in the trigger array flag monitored by this object.", null, new Dictionary<string, int>
				{
					{ "Normal", 0x00 },
					{ "Sign bit", 0x40 }
				},
				(obj) => obj.SubType & 0x40,
				(obj, value) =>
				{
					var triggerType = (int)value & 0x40;
					if (triggerType != (obj.SubType & 0x40))
					{
						obj.SubType = (byte)(obj.SubType ^ 0x40);
						obj.XFlip = !obj.XFlip;
					}
				});
			properties[2] = new PropertySpec("Movement", typeof(int), "Extended",
				"The object's movement pattern.", null, new Dictionary<string, int>
				{
					{ "Up (192px)", 0 },
					{ "Up (384px)", 1 },
					{ "Down (192px)", 2 },
					{ "Down (384px)", 3 },
				},
				(obj) => GetMovementPattern(obj),
				(obj, value) =>
				{
					var pattern = (int)value & 3;
					obj.SubType = (byte)((obj.SubType & 0x7F) | (pattern << 7));
					obj.XFlip = (obj.SubType & 0x40) == ((pattern & 2) << 5);
				});
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private int GetMovementPattern(ObjectEntry obj)
		{
			var triggerType = (obj.SubType & 0x40) != 0;
			return ((obj.XFlip ^ triggerType) ? 0 : 2) | (obj.SubType >> 7); 
		}
	}
}

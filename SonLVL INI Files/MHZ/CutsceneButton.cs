using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.MHZ
{
	class CutsceneButton : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] sprite;
		private Sprite childSprite;

		public override string Name
		{
			get { return "Cutscene Button"; }
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
			return null;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(sprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)],
				new Sprite(childSprite, 912 - obj.X, 1632 - obj.Y));
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			return new Rectangle(obj.X - 16, obj.Y - (obj.YFlip ? 4 : 12), 32, 16);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 2;
		}

		public override void Init(ObjectData data)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/MHZ/Nemesis Art/Misc Art.bin", CompressionType.Nemesis)), -4160);
			childSprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/MHZ/Misc Object Data/Map - Knuckles Switch Door.asm", 0, 3);

			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = BuildFlippedSprites(ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../General/Sprites/Buttons/Gray Button.bin", CompressionType.Nemesis),
				"../General/Sprites/Buttons/Map - Button.asm", 0, 0));
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

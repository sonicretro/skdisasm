using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.ICZ
{
	class SnowPile : ObjectDefinition
	{
		private ReadOnlyCollection<byte> subtypes;
		private IDictionary<byte, string> subtypeNames;
		private Sprite[][] sprites;

		private Sprite[] unknownSprite;

		public override string Name
		{
			get { return "Snow"; }
		}

		public override Sprite Image
		{
			get { return sprites[0][0]; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return subtypeNames[subtype];
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			return (obj.SubType & 0x7F) == 0x18 ? unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)] : null;
		}

		public override Rectangle GetBounds(ObjectEntry obj)
		{
			var bounds = (GetDebugOverlay(obj) ?? GetSprite(obj)).Bounds;
			bounds.Offset(obj.X, obj.Y);
			return bounds;
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var art = LevelData.ReadFile("../Levels/ICZ/Nemesis Art/Misc Art 2.bin", CompressionType.Nemesis);
			var map = LevelData.ASMToBin("../Levels/ICZ/Misc Object Data/Map - Platforms.asm", version);

			subtypeNames = new Dictionary<byte, string>
			{
				{ 0x00, "Snow Pile" },
				{ 0x08, "Tunnel Snow (Edge)" },
				{ 0x10, "Tunnel Snow" },
				{ 0x90, "Tunnel Snow (Start LBZ1)" },
				{ 0x18, "Snowfall" }
			};

			subtypes = new ReadOnlyCollection<byte>(new List<byte>(subtypeNames.Keys));
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			var emptySprite = new Sprite();
			sprites = new[]
			{
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 32, 2, false)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 33, 2, true)),
				BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, 34, 2, true)),
				new[] { emptySprite, emptySprite, emptySprite, emptySprite }
			};
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}

		private Sprite[] GetSubtypeSprites(byte subtype)
		{
			var offset = subtype & 0x7F;
			return (offset & 0x18) == offset ? sprites[offset >> 3] : unknownSprite;
		}
	}
}

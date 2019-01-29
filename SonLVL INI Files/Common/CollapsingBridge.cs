using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.HCZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/HCZ/Misc Object Data/Map - Collapsing Bridge.asm",
				true, -32, true, 3,
				new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Large", 1 },
					{ "Ledge", 2 },
					{ "Walkway", 3 }
				});
		}
	}
}

namespace S3KObjectDefinitions.MGZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/MGZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, false, 4,
				new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Small", 1 },
					{ "Spinner Floor", 2 }
				});

			var behavior = properties[1];
			properties[1] = new PropertySpec(behavior.Name, behavior.Type, behavior.Category,
				behavior.Description, behavior.DefaultValue, new Dictionary<string, int>
				{
					{ "Normal", 0 },
					{ "Spinner only", 1 }
				},
				(obj) => (obj.SubType & 0xF0) == 0x20 ? 1 : 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x0F) | ((int)value == 1 ? 0x20 : 0)));
		}
	}
}

namespace S3KObjectDefinitions.ICZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/ICZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, true, 1,
				new Dictionary<string, int>
				{
					{ "Normal", 1 }
				});

			sprites = new[] { sprites[1] };
			properties[0].Enumeration["Normal"] = 0;
		}

		protected override Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[0];
		}
	}
}

namespace S3KObjectDefinitions.LBZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LBZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, false, 1,
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), -32);

			sprites[1] = BuildFlippedSprites(ObjectHelper.MapASMToBmp(
				indexer.ToArray(), "../Levels/LBZ/Misc Object Data/Map - Collapsing Ledge.asm", 0, 2));

			properties[0].Enumeration.Add("Ledge", 4);
		}

		protected override Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[(subtype >> 6) & 1];
		}
	}
}

namespace S3KObjectDefinitions.FBZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/FBZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, false, 4,
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.SOZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/SOZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, false, 3,
				new Dictionary<string, int>
				{
					{ "Ledge", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.LRZ
{
	class CollapsingBridge2 : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/LRZ/Misc Object Data/Map - Collapsing Platform.asm",
				false, -4608, false, 3,
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.HPZ
{
	class CollapsingBridge : Common.CollapsingBridge
	{
		public override void Init(ObjectData data)
		{
			BuildSpritesProperties("../Levels/HPZ/Misc Object Data/Map - Collapsing Bridge.asm",
				false, -32, false, 3,
				new Dictionary<string, int>
				{
					{ "Normal", 0 }
				});
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	abstract class CollapsingBridge : ObjectDefinition
	{
		protected PropertySpec[] properties;
		protected ReadOnlyCollection<byte> subtypes;
		protected Sprite[][] sprites;

		public override string Name
		{
			get { return "Collapsing Bridge"; }
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
			return GetSubtypeSprites(subtype)[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return GetSubtypeSprites(obj.SubType)[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bounds = GetSprite(obj).Bounds;
			var overlay = new BitmapBits(bounds.Size);
			overlay.DrawRectangle(LevelData.ColorWhite, 0, 0, bounds.Width - 1, bounds.Height - 1);

			return new Sprite(overlay, bounds.X, bounds.Y);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		protected void BuildSpritesProperties(string mapfile,
			bool priority, int artoffset, bool trigger, int framebits, Dictionary<string, int> frames)
		{
			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile("LevelArt", 0)), artoffset);

			var art = indexer.ToArray();
			var map = LevelData.ASMToBin(mapfile, LevelData.Game.MappingsVersion);
			var unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprites = new Sprite[1 << framebits][];

			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = unknownSprite;
			foreach (var frame in frames.Values)
				sprites[frame] = BuildFlippedSprites(ObjectHelper.MapToBmp(art, map, frame * 3, 2, priority));

			properties[0] = new PropertySpec("Sprite", typeof(int), "Extended",
				"The object's appearance and collision size.", null, frames,
				(obj) => (obj.SubType & 0x70) >> 4,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x8F) | (((int)value << 4) & 0x70)));

			var options = new Dictionary<string, int> { { "Normal", 0 } };
			Func<ObjectEntry, object> getter = (obj) => 0;
			Action<ObjectEntry, object> setter = (obj, value) => {};

			if (trigger)
			{
				options.Add("Level trigger", 0x80);
				getter = (obj) => obj.SubType & 0x80;
				setter = (obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((int)value & 0x80));
			}

			properties[1] = new PropertySpec("Behavior", typeof(int), "Extended",
				"The method through which the object can be destroyed.", null, options, getter, setter);

			properties[2] = new PropertySpec("Delay", typeof(int), "Extended",
				"If behavior is 'level trigger', this becomes the trigger ID.", null,
				(obj) => obj.SubType & 0x0F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xF0) | ((int)value & 0x0F)));
		}

		protected virtual Sprite[] GetSubtypeSprites(byte subtype)
		{
			return sprites[(subtype >> 4) % sprites.Length];
		}

		protected Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}

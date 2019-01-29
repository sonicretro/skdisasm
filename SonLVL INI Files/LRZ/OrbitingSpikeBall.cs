using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	class OrbitingSpikeBallHorizontal : OrbitingSpikeBall
	{
		protected override bool IsVertical
		{
			get { return false; }
		}

		public override string Name
		{
			get { return "Orbiting Spike Ball (horizontal)"; }
		}
	}

	class OrbitingSpikeBallVertical : OrbitingSpikeBall
	{
		protected override bool IsVertical
		{
			get { return true; }
		}

		public override string Name
		{
			get { return "Orbiting Spike Ball (vertical)"; }
		}
	}

	abstract class OrbitingSpikeBall : ObjectDefinition
	{
		private PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite sprite;

		protected abstract bool IsVertical { get; }
		private Sprite[] unknownSprite;

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
			if ((obj.SubType & 1) != 0)
				return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];

			var angle = obj.XFlip ? 256 - (obj.SubType & 0xFE) : (obj.SubType & 0xFE);
			var offset = (int)(Math.Cos(Math.PI * (angle / 128.0)) * 32.0);

			var sprite = new Sprite(this.sprite, IsVertical ? 0 : offset, IsVertical ? offset : 0);
			if (angle >= 0x80) sprite.InvertPriority();
			return sprite;
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var bitmap = new BitmapBits(IsVertical ? 1 : 64, IsVertical ? 64 : 1);
			bitmap.DrawRectangle(LevelData.ColorWhite, 0, 0, bitmap.Width - 1, bitmap.Height - 1);
			return new Sprite(bitmap, -bitmap.Width / 2, -bitmap.Height / 2);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 5;
		}

		public override void Init(ObjectData data)
		{
			var version = LevelData.Game.MappingsVersion;
			var map = LevelData.ASMToBin(
				"../Levels/LRZ/Misc Object Data/Map - Orbiting Spike Ball.asm", version);

			properties = new PropertySpec[2];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			sprite = ObjectHelper.MapASMToBmp(LevelData.ReadFile(
				"../Levels/LRZ/Nemesis Art/Act 2 Misc Art.bin", CompressionType.Nemesis),
				"../Levels/LRZ/Misc Object Data/Map - Orbiting Spike Ball.asm", 0, 1);

			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Offset", typeof(int), "Extended",
				"The starting point of the object's movement cycle.", null,
				(obj) =>
				{
					var offset = obj.SubType & 0xFE;
					return obj.XFlip ? 256 - offset : offset;
				},
				(obj, value) =>
				{
					var offset = (int)value & 0xFE;
					obj.SubType = (byte)(obj.XFlip ? 256 - offset : offset);
				});

			properties[1] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the object will move counterclockwise.", null,
				(obj) => obj.XFlip,
				(obj, value) =>
				{
					obj.XFlip = (bool)value;
					obj.SubType = (byte)(256 - (obj.SubType & 0xFE));
				});
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

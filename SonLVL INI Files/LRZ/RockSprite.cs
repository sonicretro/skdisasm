using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LRZ
{
	[Serializable]
	public class RockSprite : ExtraObjEntry
	{
		private static Sprite[] sprites;

		[Description("The sprite's appearance.")]
		public override ushort ID { get; set; }

		public override string Name
		{
			get { return "Rock Sprite"; }
		}

		public override void UpdateSprite()
		{
			_sprite = ID < sprites.Length ? sprites[ID] : LevelData.UnknownSprite;
			_bounds = _sprite.Bounds;
			_bounds.Offset(X, Y);
		}

		public override void Init()
		{
			var art = LevelData.ReadFile("LevelArt", 0);
			var map = LevelData.ReadFile(
				"../Levels/LRZ/Misc/Rock Sprite Attribute Data.bin", CompressionType.Uncompressed);

			sprites = new Sprite[30];
			for (var index = 0; index < sprites.Length; index++)
				sprites[index] = ObjectHelper.VDPToBmp(art, map, index, true);
		}
	}
}

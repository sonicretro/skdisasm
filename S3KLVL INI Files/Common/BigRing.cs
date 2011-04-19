using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SonicRetro.S2LVL;
using System.Collections.ObjectModel;
using System.Drawing;

namespace S3KObjectDefinitions.Common
{
    public class BigRing : ObjectDefinition
    {
        private Point offset;
        private BitmapBits img;
        private int imgw, imgh;

        public override void Init(Dictionary<string, string> data)
        {
            byte[] artfile = ObjectHelper.OpenArtFile("../General/Sprites/SS Entry/Entry Ring.bin", Compression.CompressionType.Uncompressed);
            img = ObjectHelper.MapASMDPLCToBmp(artfile, "../General/Sprites/SS Entry/Map - Entry Ring.asm", "word_61A62", "../General/Sprites/SS Entry/DPLC - Special Stage Entry Ring.asm", "word_61B04", 1, out offset);
            imgw = img.Width;
            imgh = img.Height;
        }

        public override ReadOnlyCollection<byte> Subtypes()
        {
            return new ReadOnlyCollection<byte>(new byte[] { 0 });
        }

        public override string Name()
        {
            return "Special Stage Entry Ring";
        }

        public override bool RememberState()
        {
            return false;
        }

        public override string SubtypeName(byte subtype)
        {
            return string.Empty;
        }

        public override string FullName(byte subtype)
        {
            return Name();
        }

        public override BitmapBits Image()
        {
            return img;
        }

        public override BitmapBits Image(byte subtype)
        {
            return img;
        }

        public override void Draw(BitmapBits bmp, Point loc, byte subtype, bool XFlip, bool YFlip, bool includeDebug)
        {
            bmp.DrawBitmapComposited(img, new Point(loc.X + offset.X, loc.Y + offset.Y));
        }

        public override Rectangle Bounds(System.Drawing.Point loc, byte subtype)
        {
            return new Rectangle(loc.X + offset.X, loc.Y + offset.Y, imgw, imgh);
        }
    }
}

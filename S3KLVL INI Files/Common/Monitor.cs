using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using Extensions;
using SonicRetro.S2LVL;

namespace S3KObjectDefinitions.Common
{
    class Monitor : ObjectDefinition
    {
        private string[] labels = { "word_1DBC2", "word_1DBD0", "word_1DBDE", "word_1DBEC", "word_1DBFA", "word_1DC08", "word_1DC16", "word_1DC24", "word_1DC32", "word_1DC40", "word_1DC4E" };
        private Point offset;
        private Bitmap img;
        private int imgw, imgh;
        private List<Point> offsets = new List<Point>();
        private List<Bitmap> imgs = new List<Bitmap>();
        private List<int> imgws = new List<int>();
        private List<int> imghs = new List<int>();

        public override void Init(Dictionary<string, string> data)
        {
            List<byte> tmpartfile = new List<byte>();
            tmpartfile.AddRange(ObjectHelper.OpenArtFile("../General/Sprites/Monitors/Monitors.bin", Compression.CompressionType.Nemesis));
            tmpartfile.AddRange(new byte[0x6200 - tmpartfile.Count]);
            tmpartfile.AddRange(ObjectHelper.OpenArtFile("../General/Sprites/HUD Icon/Sonic life icon.bin", Compression.CompressionType.Nemesis));
            byte[] artfile = tmpartfile.ToArray();
            img = ObjectHelper.MapASMToBmp(artfile, "../General/Sprites/Monitors/Map - Monitor.asm", "word_1DBBA", 0, out offset);
            imgw = img.Width;
            imgh = img.Height;
            Point off;
            Bitmap im;
            for (int i = 0; i < labels.Length; i++)
            {
                im = ObjectHelper.MapASMToBmp(artfile, "../General/Sprites/Monitors/Map - Monitor.asm", labels[i], 0, out off);
                imgs.Add(im);
                offsets.Add(off);
                imgws.Add(im.Width);
                imghs.Add(im.Height);
            }
        }

        public override ReadOnlyCollection<byte> Subtypes()
        {
            return new ReadOnlyCollection<byte>(new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 });
        }

        public override string Name()
        {
            return "Monitor";
        }

        public override bool RememberState()
        {
            return true;
        }

        public override string SubtypeName(byte subtype)
        {
            switch (subtype)
            {
                case 0:
                    return "Static";
                case 1:
                    return "1-up";
                case 2:
                    return "Eggman";
                case 3:
                    return "Rings";
                case 4:
                    return "Shoes";
                case 5:
                    return "Fire Shield";
                case 6:
                    return "Lightning Shield";
                case 7:
                    return "Water Shield";
                case 8:
                    return "Invincibility";
                case 9:
                    return "S";
                case 10:
                    return "Broken";
                default:
                    return string.Empty;
            }
        }

        public override string FullName(byte subtype)
        {
            return SubtypeName(subtype) + " " + Name();
        }

        public override Bitmap Image()
        {
            return img;
        }

        public override Bitmap Image(byte subtype)
        {
            if (subtype <= 10)
                return imgs[subtype];
            else
                return img;
        }

        public override void Draw(Graphics gfx, Point loc, byte subtype, bool XFlip, bool YFlip)
        {
            if (subtype <= 10)
                gfx.DrawImageFlipped(imgs[subtype], loc.X + offsets[subtype].X, loc.Y + offsets[subtype].Y, XFlip, YFlip);
            else
                gfx.DrawImageFlipped(img, loc.X + offset.X, loc.Y + offset.Y, XFlip, YFlip);
        }

        public override Rectangle Bounds(Point loc, byte subtype)
        {
            if (subtype <= 10)
                return new Rectangle(loc.X + offsets[subtype].X, loc.Y + offsets[subtype].Y, imgws[subtype], imghs[subtype]);
            else
                return new Rectangle(loc.X + offset.X, loc.Y + offset.Y, imgw, imgh);
        }

        public override void DrawExport(BitmapBits bmp, Point loc, byte subtype, bool XFlip, bool YFlip, bool includeDebug)
        {
            if (subtype > 10) subtype = 0;
            BitmapBits bits = new BitmapBits(imgs[subtype]);
            bits.Flip(XFlip, YFlip);
            bmp.DrawBitmapComposited(bits, new Point(loc.X + offsets[subtype].X, loc.Y + offsets[subtype].Y));
        }

        public override void PaletteChanged(System.Drawing.Imaging.ColorPalette pal)
        {
            img.Palette = pal;
            foreach (Bitmap item in imgs)
            {
                item.Palette = pal;
            }
        }
    }
}
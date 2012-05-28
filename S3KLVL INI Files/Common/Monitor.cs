using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.Common
{
    class Monitor : ObjectDefinition
    {
        private Sprite img;
        private List<Sprite> imgs = new List<Sprite>();

        public override void Init(ObjectData data)
        {
            List<byte> tmpartfile = new List<byte>();
            tmpartfile.AddRange(ObjectHelper.OpenArtFile("../General/Sprites/Monitors/Monitors.bin", Compression.CompressionType.Nemesis));
            tmpartfile.AddRange(new byte[0x6200 - tmpartfile.Count]);
            tmpartfile.AddRange(ObjectHelper.OpenArtFile("../General/Sprites/HUD Icon/Sonic life icon.bin", Compression.CompressionType.Nemesis));
            byte[] artfile = tmpartfile.ToArray();
            img = ObjectHelper.MapASMToBmp(artfile, "../General/Sprites/Monitors/Map - Monitor.asm", 0, 0);
            for (int i = 0; i < 11; i++)
                imgs.Add(ObjectHelper.MapASMToBmp(artfile, "../General/Sprites/Monitors/Map - Monitor.asm", i + 1, 0));
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
                    return "Invalid";
            }
        }

        public override BitmapBits Image()
        {
            return img.Image;
        }

        public override BitmapBits Image(byte subtype)
        {
            if (subtype <= 10)
                return imgs[subtype].Image;
            else
                return img.Image;
        }

        public override Rectangle Bounds(ObjectEntry obj, Point camera)
        {
            if (obj.SubType <= 10)
                return new Rectangle(obj.X + imgs[obj.SubType].X - camera.X, obj.Y + imgs[obj.SubType].Y - camera.Y, imgs[obj.SubType].Width, imgs[obj.SubType].Height);
            else
                return new Rectangle(obj.X + img.X - camera.X, obj.Y + img.Y - camera.Y, img.Width, img.Height);
        }

        public override Sprite GetSprite(ObjectEntry obj)
        {
            byte subtype = obj.SubType;
            if (subtype > 10) subtype = 0;
            BitmapBits bits = new BitmapBits(imgs[subtype].Image);
            bits.Flip(obj.XFlip, obj.YFlip);
            return new Sprite(bits, new Point(imgs[subtype].X + obj.X, imgs[subtype].Y + obj.Y));
        }

        public override Type ObjectType { get { return typeof(MonitorS3KObjectEntry); } }
    }

    public class MonitorS3KObjectEntry : S3KObjectEntry
    {
        public MonitorS3KObjectEntry() : base() { }
        public MonitorS3KObjectEntry(byte[] file, int address) : base(file, address) { }

        public MonitorType Contents
        {
            get
            {
                if (SubType > 10) return MonitorType.Invalid;
                return (MonitorType)SubType;
            }
            set
            {
                SubType = (byte)value;
            }
        }
    }

    public enum MonitorType
    {
        Static,
        OneUp,
        Eggman,
        Rings,
        Shoes,
        FireShield,
        LightningShield,
        WaterShield,
        Invincibility,
        S,
        Broken,
        Invalid
    }
}
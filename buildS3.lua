#!/usr/bin/env lua

local base = require "build_tools.lua.common"

os.exit(base.build_rom("s3", "s3built", "", "-p=FF -z=0,uncompressed,Size_of_Snd_driver_guess,before -z=1300,uncompressed,Size_of_Snd_driver2_guess,before", false, "https://github.com/sonicretro/skdisasm"))

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s3built.bin")

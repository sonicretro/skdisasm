#!/usr/bin/env lua

local common = require "build_tools.lua.common"

local exit_code

local message, abort = common.build_rom("s3", "s3built", "", "-p=FF -z=0,uncompressed,Size_of_Snd_driver_guess,before -z=1300,uncompressed,Size_of_Snd_driver2_guess,before", false, "https://github.com/sonicretro/skdisasm")

if message then
	exit_code = false
end

if abort then
	os.exit(exit_code, true)
end

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s3built.bin")

os.exit(exit_code, false)

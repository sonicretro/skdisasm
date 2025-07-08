#!/usr/bin/env lua

local common = require "build_tools.lua.common"

-- Produce PCM and DPCM data.
common.convert_pcm_files_in_directory("Sound/PCM")
common.convert_dpcm_files_in_directory("Sound/DAC")

-- Build the ROM.
common.build_rom_and_handle_failure("s3", "s3built", "", "-p=FF -z=0,uncompressed,Size_of_Snd_driver_guess,before -z=1300,uncompressed,Size_of_Snd_driver2_guess,before", false, "https://github.com/sonicretro/skdisasm")

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s3built.bin")

-- A successful build; we can quit now.
common.exit()

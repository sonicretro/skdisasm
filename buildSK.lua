#!/usr/bin/env lua

--------------
-- Settings --
--------------

-- Set this to true to use a better compression algorithm for the sound driver.
-- Having this set to false will use an inferior compression algorithm that
-- results in an accurate ROM being produced.
local improved_sound_driver_compression = false

---------------------
-- End of settings --
---------------------

-------------------------------------
-- Actual build script begins here --
-------------------------------------

local common = require "build_tools.lua.common"

-- Produce PCM and DPCM data.
common.convert_pcm_files_in_directory("Sound/PCM")
common.convert_dpcm_files_in_directory("Sound/DAC")

-- Build the ROM.
local compression = improved_sound_driver_compression and "kosinski-optimised" or "kosinski"
common.build_rom_and_handle_failure("sonic3k", "skbuilt", "-D Sonic3_Complete=0", "-p=FF -z=0," .. compression .. ",Size_of_Snd_driver_guess,before -z=1300," .. compression .. ",Size_of_Snd_driver2_guess,before", false, "https://github.com/sonicretro/skdisasm")

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("skbuilt.bin")

-- A successful build; we can quit now.
common.exit()

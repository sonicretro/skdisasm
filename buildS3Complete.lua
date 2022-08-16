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

local base = require "build_tools.lua.base"

os.exit(base.build_rom("sonic3k", "sonic3k", "-D Sonic3_Complete=1", improved_sound_driver_compression))

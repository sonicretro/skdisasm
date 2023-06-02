#!/usr/bin/env lua

local base = require "build_tools.lua.common"

os.exit(base.build_rom("s3", "s3built", "", "-p=FF", false, true, "https://github.com/sonicretro/skdisasm"))

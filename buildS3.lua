#!/usr/bin/env lua

local base = require "build_tools.lua.base"

os.exit(base.build_rom("s3", "s3built", "", false))

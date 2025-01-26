-- luacheck: ignore 111 113
---@diagnostic disable: undefined-global
kpse.set_program_name(status.list().luatex_engine)
local prompt = require 'prompt'
local utils = require "prompt.utils"

utils.init()
print()
prompt.enter()

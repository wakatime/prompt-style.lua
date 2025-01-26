-- luacheck: ignore 111 112 113
---@diagnostic disable: undefined-global
if not texconfig.prompt_init then
  -- FIXME: no format given, quitting
  -- kpse.set_program_name(status.list().luatex_engine)
  local configs = { os.getenv('HOME') .. '/.luaprc.lua',
    os.getenv('HOME') .. '/.config/luaprc.lua' }
  for _, name in ipairs(configs) do
    local f = io.open(name, "r")
    if f ~= nil then
      io.close(f)
      local chunk, message = loadfile(name)
      if chunk then
        chunk()
      else
        print(message)
      end
      break
    end
  end

  require 'prompt'
  texconfig.prompt_init = true
  return
end
local prompt = require 'prompt'
local utils = require "prompt.utils"

utils.init()
print()
prompt.enter()

local style = require "prompt.style"

-- luacheck: ignore 113
---@diagnostic disable: undefined-global
describe("test", function()
    it("tests style", function()
        assert.are.equal(style.get_version("Lua", "logo"), "logo " .. _VERSION)
    end)
end)

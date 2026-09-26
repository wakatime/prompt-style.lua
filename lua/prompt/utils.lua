---utils.
local M = {}

---get the first non-nil element's index
---@param args string[] index can be negative
---@return integer begin begin index
function M.get_begin_index(args)
    local begin = -1
    while args[begin] do
        begin = begin - 1
    end
    begin = begin + 1
    return begin
end

---texlua has a behaviour about command line arguments.
---`arg` starts from index 0: `arg = {[0] = "ls", "-al"}`
---`os.exec()` starts from index 1: `os.exec{"ls", "-al"}`
---we need to shift it
---@param argv string[] command line arguments
---@param offset integer e.g., `-1` means `args[i + 1] = args[i]`
---@return string[] args
function M.shift(argv, offset)
    local begin = M.get_begin_index(argv)

    local args = {}
    for i = begin, #argv do
        args[i - offset] = argv[i]
    end
    return args
end

---get offset from one script to another script
---such as `texlua --option main.lua --option` -> `main.lua --option`
---offset should be 2
---@param args string[] command line arguments
---@return integer offset
function M.get_offset(args)
    local offset
    for i, v in ipairs(args) do
        local char = v:sub(1, 1)
        -- skip \macro and --option
        if char ~= "\\" and char ~= "-" then
            offset = i
            break
        end
    end
    return offset
end

---@param args string[] command line arguments
---@param extra_offset integer? extra offset
---@return string[] args parsed result
function M.parse(args, extra_offset)
    local offset = M.get_offset(args)
    return M.shift(args, offset + (extra_offset or 0))
end

return M

---prompt utils.
local argparse = require "argparse"
local prompt = require "prompt"
local M = {}

---get a parser with same command line options as lua
---@return table
function M.get_parser()
    -- Define the command-line argument parser.
    local name
    if arg and arg[0] then
        name = arg[0]:gsub(".*/", "")
    else
        name = prompt.name .. "p"
    end
    local parser = argparse()
        :name(name)
        :description "A Lua command prompt with pretty-printing and auto-completion."
        :add_help "-h"
        :add_complete({ hidden = true })

    -- Options

    parser:option "-e"
        :argname "STMT"
        :description "Execute string 'STMT'."
        :count "*"

    parser:option "-l"
        :argname "NAME"
        :description "Require library 'NAME'."
        :count "*"

    if jit then
        parser:option "-j"
            :argname "CMD"
            :description "Perform LuaJIT control command."
            :count "*"
        parser:option "-O"
            :argname "OPT"
            :description "Control LuaJIT optimizations."
            :count "*"
    end

    -- Flags

    parser:flag "-p"
        :description "Force plain, uncolored output."

    parser:flag "-v"
        :description "Print version information."

    parser:flag "-i"
        :description "Enter interactive mode."

    -- Arguments

    parser:argument "SCRIPT"
        :description [[A Lua script to be executed.  Any arguments
specified after the script name, are passed to
the script.]]
        :args '*'

    return parser
end

---process args
---@param args table
---@param parser table
function M.process_args(args, parser)
    if args.v then
        if prompt.name then
            local f = io.popen(prompt.name .. ' --version')
            if f then
                local line = f:read()
                while line do
                    print(line)
                    line = f:read()
                end
                f:close()
            else
                print(prompt.copyrights[2])
            end
        else
            print(prompt.copyrights[2])
        end
        os.exit(0)
    end

    -- Pass optimization options to LuaJIT.

    if args.O then
        for _, O in ipairs(args.O) do
            jit.opt.start(O)
        end
    end

    local interactive = (args.i or (prompt.interactive and
        #args.SCRIPT == 0 and #args.e == 0))

    -- Parse control commands and pass them to LuaJIT.

    if args.j then
        for _, j in ipairs(args.j) do
            local unpack = unpack or table.unpack

            -- Parse the command name.

            local name = j:match('^[^=]+')

            if not name then
                print(parser:get_help())
                os.exit(0)
            end

            -- Parse the arguments, if any.

            local _args = {}

            for _arg in (j:match('=(.*)$') or ""):gmatch('[^,]+') do
                table.insert(_args, _arg)
            end

            -- Look for a builtin command.

            if jit[name] then
                jit[name](unpack(_args))
            else
                local ok, m = pcall(require, 'jit.' .. name)

                if not ok or not m then
                    parser:error('unknown luaJIT command or ' ..
                        'jit.* modules not installed')
                end

                m.start(unpack(_args))
            end
        end
    end

    -- Require modules specified on the command line.

    if #args.l > 0 then
        for _, l in ipairs(args.l) do
            if _VERSION == "Lua 5.1" then
                require(l)
            else
                _G[l] = require(l)
            end
        end
    end

    -- Load and execute chunks passed on the command line.

    if #args.e > 0 then
        local loadstring = loadstring or load
        for _, e in ipairs(args.e) do
            loadstring(e)()
        end
    end

    -- Run the script given on the command line, passing any arguments as
    -- required.

    if #args.SCRIPT > 0 or (not interactive and #args.e == 0) then
        local chunk, message
        local loadstring = loadstring or load
        local unpack = unpack or table.unpack
        local name

        if #args.SCRIPT > 0 then
            name = table.remove(args.SCRIPT, 1)
        else
            name = "-"
        end

        if name == "-" then
            chunk, message = loadstring(io.stdin:read("*a"))
        else
            chunk, message = loadfile(name)
        end

        if chunk then
            -- This duplicates the behavior of the standard Lua interpreter
            -- to some extent.  Arguments prior to the script name are not
            -- passed.

            -- luacheck: ignore 121
            arg = { [0] = name, unpack(args.SCRIPT) }
            prompt.call(chunk, unpack(args.SCRIPT))
        else
            print(message)
            os.exit(0)
        end
    end
    if interactive then
        prompt.enter()
    end
end

---init prompt
function M.init()
    if arg[0] and prompt.name == "lua" then
        prompt.name = arg[0]:gsub(".*/", ""):gsub("p$", "")
    end
    prompt.prompts = prompt.prompts or { '>  ', '>> ' }
    if prompt.colorize == nil then
        prompt.colorize = true
    end
    prompt.history = prompt.history or os.getenv('HOME') .. '/.lua_history'
end

---source configs
---@param configs string[] | nil
function M.source_configs(configs)
    configs = configs or { os.getenv('HOME') .. '/.luaprc.lua',
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
end

---@export
return M

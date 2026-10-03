---REPL.
local argparse = require "argparse-temp"
local style = require "prompt.style"
local utils = require "prompt.utils"
local M = {}

---get a parser with same command line options as lua
---@return table
function M.get_parser()
    -- Define the command-line argument parser.
    local parser = argparse(arg[0])
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
        :args '...'

    return parser
end

---**entry for texlua**
---@param argv string[] command line arguments
---@param callback function? handle `args`, call M.source_user_configs()
function M.main(argv, callback)
    local parser = M.get_parser()
    local args = parser:parse(argv)
    M.source_default_config()
    callback = callback or M.callback
    args = callback(args)
    M.process_args(args, parser)
end

---init prompt
function M.source_default_config()
    local prompt = require "prompt"
    -- luacheck: ignore 111 113
    ---@diagnostic disable: undefined-global
    if prompt.name == "lua" then
        if vim then
            prompt.name = "nvim"
        elseif pandoc then
            prompt.name = "pandoc"
        elseif status then
            prompt.name = status.list().luatex_engine
        elseif arg and arg[0] then
            prompt.name = arg[0]:gsub(".*/", ""):gsub("p$", "")
        end
    end

    prompt.prompts = { style.generate_ps1(), "    " }
    if prompt.colorize == nil then
        prompt.colorize = true
    end
    prompt.history = prompt.history or (os.getenv 'HOME' or os.getenv 'USERPROFILE' or ".") .. '/.lua_history'
end

---source configs
---@param configs string[]?
function M.source_user_configs(configs)
    local PlatformDirs = require "platformdirs".PlatformDirs
    configs = configs or { PlatformDirs { appname = "luaprc.lua" }:user_config_dir() }
    for _, name in ipairs(configs) do
        local f = io.open(name)
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

---callback
---@param args table
---@return table
function M.callback(args)
    -- luacheck: ignore 111 113
    ---@diagnostic disable: undefined-global
    if args.v then
        if vim then
            vim.cmd.version()
        elseif mutt then
            mutt.command.version()
        elseif tex then
            print(require 'status'.banner)
        end
        os.exit(0)
    end
    -- ~/.config/vim/init.lua
    -- ~/.config/neomutt/neomuttrc
    -- $PYTHONSTARTUP
    if not (vim or mutt or python) then
        M.source_user_configs()
    end
    return args
end

---process args
---@param args table
---@param parser table
function M.process_args(args, parser)
    local prompt = require "prompt"
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
            -- not remove it!
            name = args.SCRIPT[1]
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

            -- shift arg[0] to the script name
            -- luacheck: ignore 121
            arg = utils.shift(arg, #arg - #args.SCRIPT + 1)
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

---@export
return M

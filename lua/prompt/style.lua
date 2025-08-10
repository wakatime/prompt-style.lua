---prompt style.
local os = require "os"
local table = require "table"
local lfs = require"lfs"
local warna = require "warna"
warna.options.level = 3
local ansicolors = warna.format
local prompt = require "prompt"
---@diagnostic disable: deprecated
if table.unpack == nil then table.unpack = unpack end

---wakatime
---@param cmd string | nil
---@return string
local function wakatime(cmd)
    cmd = cmd or ("wakatime-cli --write --plugin=repl-lua-wakatime " ..
        "--entity-type=app --entity=lua --alternate-language=lua --project=%s &")
    local s, _ = cmd:find("%s")
    if s ~= nil then
        local f = io.popen("git rev-parse --show-toplevel 2> /dev/null")
        -- specific command execution disabled
        if f == nil then
            return ""
        end
        local project = f:read()
        f:close()
        if project == nil then
            project = lfs.currentdir()
        end
        project = project:match("[^/]+$")
        cmd = cmd:format(project)
    end
    io.popen(cmd)
    return ""
end

---get distribution
---@return string
local function get_distribution()
    local f = io.open("/etc/artix-release")
    if f then
        f:close()
        return "artix"
    end
    f = io.open("/etc/os-release")
    if f == nil then
        f = io.open("/usr/lib/os-release")
    end
    if f then
        local result
        for line in f:lines() do
            if line:match("^ID=") then
                result = line:gsub("^ID=", "")
                break
            end
        end
        f:close()
        if result:match("arch") then
            return "arch"
        elseif result:match("debian") then
            return "debian"
        elseif result:match("raspbian") then
            return "raspbian"
        elseif result:match("ubuntu") then
            return "ubuntu"
        elseif result:match("elementary") then
            return "elementary"
        elseif result:match("fedora") then
            return "fedora"
        elseif result:match("coreos") then
            return "coreos"
        elseif result:match("kali") then
            return "kali"
        elseif result:match("gentoo") then
            return "gentoo"
        elseif result:match("mageia") then
            return "mageia"
        elseif result:match("centos") then
            return "centos"
        elseif result:match("opensuse") then
            return "opensuse"
        elseif result:match("tumbleweed") then
            return "opensuse"
        elseif result:match("sabayon") then
            return "sabayon"
        elseif result:match("slackware") then
            return "slackware"
        elseif result:match("linuxmint") then
            return "mint"
        elseif result:match("alpine") then
            return "alpine"
        elseif result:match("aosc") then
            return "aosc"
        elseif result:match("nixos") then
            return "nixos"
        elseif result:match("devuan") then
            return "devuan"
        elseif result:match("manjaro") then
            return "manjaro"
        elseif result:match("void") then
            return "void"
        elseif result:match("artix") then
            return "artix"
        elseif result:match("rhel") then
            return "rhel"
        elseif result:match("amzn") then
            return "amzn"
        elseif result:match("endeavouros") then
            return "endeavouros"
        elseif result:match("rocky") then
            return "rocky"
        elseif result:match("guix") then
            return "guix"
        elseif result:match("dock") then
            return "docker"
        end
    end
    return "linux"
end

---get os
---@return string
local function get_os()
    if os.getenv("PREFIX") == "/data/data/com.termux/files/usr" then
        return "android"
    end
    local binary_format = package.cpath:match('([^.]+)$'):gsub(";$", "")
    if binary_format == "so" then
        return get_distribution()
    elseif binary_format == "dll" then
        return "windows"
    elseif binary_format == "dylib" then
        return "macos"
    end
    return "unknown"
end

---get icon
---@return string
local function get_icon()
    local icons = {
        unknown = "?",
        alpine = "",
        amzn = "",
        android = "",
        aosc = "",
        arch = "",
        artix = "",
        centos = "",
        coreos = "",
        debian = "",
        devuan = "",
        docker = "",
        elementary = "",
        endeavouros = "",
        fedora = "",
        freebsd = "",
        gentoo = "",
        guix = "",
        kali = "",
        linux = "",
        macos = "",
        mageia = "",
        manjaro = "",
        mint = "",
        nixos = "",
        opensuse = "",
        raspbian = "",
        rhel = "",
        rocky = "",
        sabayon = "",
        slackware = "",
        sunos = "",
        ubuntu = "",
        void = "",
        windows = "",
    }
    return icons[get_os()]
end

---get version
---@param name string | nil
---@param logo string | nil
---@param format string | nil
---@return string
local function get_version(name, logo, format)
    name = name or prompt.name
    logo = logo or ""
    format = format or " %s "
    name = format:format(name)
    local version = _VERSION:gsub(".*%s+", "")
    return logo .. name .. version
end

---get time
---@param format string | nil
---@return string
local function get_time(format)
    format = format or "%H:%M:%S"
    local time = os.date(format, os.time())
    if type(time) == "string" then return time end
    return ""
end

---get cwd
---@return string
local function get_cwd()
    local cwd = lfs.currentdir():gsub(os.getenv("HOME") or "", "~")
    cwd = cwd:gsub("[^/]+$", "%%{bright}%0")
    return cwd
end

---generate ps1.
-- `sections` is an array whose element is like `{ "white", "blue",   get_cwd }`
-- and its order determine the order of prompt sections.
---@param char string | nil
---@param sections {(1: integer, 2: integar, 3: string | function(): string) | string}[]
---@return function(): string
local function generate_ps1(char, sections)
    char = char or "❯ "
    sections = sections or {
        ---@diagnostic disable: missing-parameter
        { "",      "",       wakatime },
        { "black", "yellow", get_icon() }, { "blue", "black", get_version() },
        { "white", "blue", get_cwd }, { "black", "white", get_time }
    }
    local sep = ""
    local format = " %s "
    return function()
        local ps1 = ""
        local last_bg = ""
        for _, v in ipairs(sections) do
            if type(v) == "string" then
                if v:match("%s") then
                    format = v
                else
                    sep = v
                end
            else
                local fg, bg, text = table.unpack(v)
                if type(text) == "function" then text = text() end
                if text ~= "" then
                    text = format:format(text)
                    if last_bg == "" then
                        ps1 = ps1 .. "%{" .. fg .. " bg-" .. bg .. "}" .. text
                    else
                        ps1 = ps1 .. "%{" .. last_bg .. " bg-" .. bg .. "}" .. sep ..
                            "%{" .. fg .. "}" .. text
                    end
                    last_bg = bg
                end
            end
        end
        ps1 = ps1 .. "%{reset " .. last_bg .. "}" .. sep
        return ansicolors(ps1) .. "\n" .. char
    end
end

---@export
return {
    wakatime = wakatime,
    get_distribution = get_distribution,
    get_os = get_os,
    get_icon = get_icon,
    get_version = get_version,
    get_time = get_time,
    get_cwd = get_cwd,
    generate_ps1 = generate_ps1
}

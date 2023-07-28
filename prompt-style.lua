---prompt style.
local os = require "os"
local string = require "string"
local table = require "table"
local lfs = require "lfs"
local ansicolors = require "ansicolors"
if table.unpack == nil then table.unpack = unpack end

---get distribution
---@return string
local function get_distribution()
    local line = io.popen("lsb_release -i 2>/dev/null", "r"):read()
    if line == nil then return "linux" end
    return string.lower(string.gsub(line, ".*:%s*", ""))
end

---get os
---@return string
local function get_os()
    if os.getenv("PREFIX") == "/data/data/com.termux/files/usr" then
        return "android"
    end
    local binary_format = string.match(package.cpath, '([^.]+)[;|$]')
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
        android = "",
        arch = "",
        centos = "",
        debian = "",
        docker = "",
        gentoo = "",
        linux = "",
        macos = "",
        ubuntu = "",
        nixos = "",
        windows = ""
    }
    return icons[get_os()]
end

---get version
---@param logo string
---@return string
local function get_version(logo)
    logo = logo or " "
    local version = string.gsub(_VERSION, ".*%s+", "")
    return logo .. version
end

---get time
---@param format string
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
    local cwd = string.gsub(lfs.currentdir(), os.getenv("HOME") or "", "~")
    cwd = string.gsub(cwd, "[^/]+$", "%%{bright}%0")
    return cwd
end

---generate ps1.
-- `sections` is an array whose element is like `{ "white", "blue",   get_cwd }`
-- and its order determine the order of prompt sections.
-- `sep` is separator. `char` is the last character like `> `
-- `format` determine the space and by default is ' %s '.
---@param sections {1: integer, 2: integar, 3: string | function(): string}[]
---@param sep string
---@param char string
---@param format string
---@return function(): string
local function generate_ps1(sections, sep, char, format)
    sections = sections or {
        {"black", "yellow", get_icon()}, {"blue", "black", get_version()},
        {"white", "blue", get_cwd}, {"black", "white", get_time}
    }
    sep = sep or ""
    char = char or "❯ "
    format = format or " %s "
    return function()
        local ps1 = ""
        local last_bg = ""
        for _, v in ipairs(sections) do
            local fg, bg, text = table.unpack(v)
            if type(text) == "function" then text = text() end
            text = string.format(format, text)
            if last_bg ~= "" then
                ps1 = ps1 .. "%{" .. last_bg .. " " .. bg .. "bg}" .. sep
            end
            ps1 = ps1 .. "%{" .. fg .. " " .. bg .. "bg}" .. text
            last_bg = bg
        end
        ps1 = ps1 .. "%{reset " .. last_bg .. "}"
        return ansicolors(ps1) .. "\n" .. char
    end
end

---@export
return {
    get_distribution = get_distribution,
    get_os = get_os,
    get_icon = get_icon,
    get_version = get_version,
    get_time = get_time,
    get_cwd = get_cwd,
    generate_ps1 = generate_ps1
}

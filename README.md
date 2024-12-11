# prompt-style.lua

[![readthedocs](https://shields.io/readthedocs/prompt-stylelua)](https://prompt-stylelua.readthedocs.io)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/wakatime/prompt-style.lua/main.svg)](https://results.pre-commit.ci/latest/github/wakatime/prompt-style.lua/main)
[![github/workflow](https://github.com/wakatime/prompt-style.lua/actions/workflows/main.yml/badge.svg)](https://github.com/wakatime/prompt-style.lua/actions)
[![codecov](https://codecov.io/gh/wakatime/prompt-style.lua/branch/main/graph/badge.svg)](https://codecov.io/gh/wakatime/prompt-style.lua)
[![DeepSource](https://deepsource.io/gh/wakatime/prompt-style.lua.svg/?show_trend=true)](https://deepsource.io/gh/wakatime/prompt-style.lua)

[![github/downloads](https://shields.io/github/downloads/wakatime/prompt-style.lua/total)](https://github.com/wakatime/prompt-style.lua/releases)
[![github/downloads/latest](https://shields.io/github/downloads/wakatime/prompt-style.lua/latest/total)](https://github.com/wakatime/prompt-style.lua/releases/latest)
[![github/issues](https://shields.io/github/issues/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/discussions)
[![github/milestones](https://shields.io/github/milestones/all/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/milestones)
[![github/forks](https://shields.io/github/forks/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/network/members)
[![github/stars](https://shields.io/github/stars/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/stargazers)
[![github/watchers](https://shields.io/github/watchers/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/watchers)
[![github/contributors](https://shields.io/github/contributors/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/commits)
[![github/release-date](https://shields.io/github/release-date/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/releases/latest)

[![github/license](https://shields.io/github/license/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)
[![github/languages/top](https://shields.io/github/languages/top/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)
[![github/directory-file-count](https://shields.io/github/directory-file-count/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)
[![github/code-size](https://shields.io/github/languages/code-size/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)
[![github/repo-size](https://shields.io/github/repo-size/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)
[![github/v](https://shields.io/github/v/release/wakatime/prompt-style.lua)](https://github.com/wakatime/prompt-style.lua)

[![luarocks](https://img.shields.io/luarocks/v/Freed-Wu/prompt-style)](https://luarocks.org/modules/Freed-Wu/prompt-style)

This project provides some tools related to
[luaprompt](https://github.com/dpapavas/luaprompt):

## A prompt with [powerlevel10k](https://github.com/romkatv/powerlevel10k) style

![luap](https://user-images.githubusercontent.com/32936898/255322845-c4c6e13c-3b39-4315-b09b-206a1a7783ea.png)

`~/.config/luaprc.lua`:

```lua
local prompt = require "prompt"
local style = require "prompt.style"

prompt.prompts = { style.generate_ps1(), "    " }
```

## A wakatime plugin to statistic how much time you write lua in REPL

![wakatime](https://github.com/wakatime/prompt-style.lua/assets/32936898/b4397806-0ab3-4751-baaa-d9dfed92ace7)

If there is a git repository, the project name can be achieved by git. Else use
the base name of current working directory.
You can call `(require "prompt.style").wakatime("wakatime-cli XXX")` to
customize it.

See
[![readthedocs](https://shields.io/readthedocs/prompt-stylelua)](https://prompt-stylelua.readthedocs.io).

## REPLs for many programs containing a lua interpreters

### Lua 5.1/LuaJIT

#### [neovim](https://neovim.io)

![cmd](https://github.com/user-attachments/assets/26a34d2e-7db9-412c-beb3-87b8598294f9)

`~/.config/nvim/init.lua`:

```lua
local l_flag = false
for _, arg in ipairs(vim.v.argv) do
    if l_flag == true then
        vim.g.script_name = vim.fs.basename(arg)
        break
    end
    if arg == "-l" then
        l_flag = true
    end
end
if vim.g.script_name == "nvimp" then
    require"prompt".name = "nvim"
    loadfile(vim.fs.joinpath(os.getenv("HOME"), ".config", "luaprc.lua"))()
    -- skip loading unnecessary vim plugins
    return
end
```

#### luajittex

Refer [luatex](#luatex).

### Lua 5.3

#### luatex

![texluap](https://github.com/wakatime/prompt-style.lua/assets/32936898/96d9f4c1-55fc-4ae3-87b8-7afd29f4ba0e)

#### [neomutt](https://neomutt.org)

Broken in [upstream](https://github.com/neomutt/neomutt/issues/4328)

### Lua 5.4

#### [pandoc](https://pandoc.org)

![pandocp](https://github.com/wakatime/prompt-style.lua/assets/32936898/b556effe-6be7-4cf9-b612-b1283d6de721)

## Install

### [AUR](https://aur.archlinux.org/packages/lua-prompt-style)

```sh
paru -S lua{,51,52,53}-prompt-style
```

### [Luarocks](https://luarocks.org/modules/Freed-Wu/prompt-style)

```sh
luarocks install prompt-style
```

## Related Projects

- [neolua](https://github.com/nvim-neorocks/neorocks): Another lua interpreter
  based on neovim like `nvimp`. It doesn't provide a REPL like lua.
- [nlua](https://github.com/mfussenegger/nlua): Another lua interpreter
  based on neovim like `nvimp`. It doesn't provide a REPL like lua.

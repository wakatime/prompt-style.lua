# prompt-style.lua

[![readthedocs](https://shields.io/readthedocs/prompt-style-lua)](https://prompt-style-lua.readthedocs.io)
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

## Install

### [AUR](https://aur.archlinux.org/packages/lua-prompt-style)

```sh
paru -S lua{,51,52,53}-prompt-style
```

### [Luarocks](https://luarocks.org/modules/Freed-Wu/prompt-style)

```sh
luarocks install prompt-style
```

## Configure

You can config it by `~/.config/luaprc.lua` which is used by all programs based
on [luaprompt](https://github.com/dpapavas/luaprompt).

```sh
local prompt = require'prompt'
if kpse then
    -- for texlua
    kpse.set_program_name'texlua'
    prompt.history = kpse.expand_path'~' .. '/.lua_history'
    prompt.prompts = { "> ", "    " }
elseif vim then
    -- for nvimp
    prompt.history = vim.fs.joinpath(vim.fn.stdpath'data', '.lua_history')
    prompt.prompts = { "> ", "    " }
else
    -- for luap
    prompt.history = (os.getenv'HOME' or os.getenv'USERPROFILE' or '.') .. '/.lua_history'
    prompt.prompts = { "> ", "    " }
end
```

- [texluap](https://texrocks.readthedocs.io/en/latest/topics/texluap.md.html):
  for LuaLaTeX
- [wezterm](https://github.com/wez/wezterm):
  - `wezterm --config-file /the/path/weztermp`
  - doesn't support shebang
  - can't load C modules in safe mode
- [xmake](https://github.com/xmake-io/xmake):
  - `xmake l /the/path/xmake.lua`
  - doesn't support shebang
  - xmake doesn't provide `require()`

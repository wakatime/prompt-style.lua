# prompt-style.lua

[![readthedocs](https://shields.io/readthedocs/prompt-stylelua)](https://prompt-stylelua.readthedocs.io)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/prompt-style.lua/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/prompt-style.lua/main)
[![github/workflow](https://github.com/Freed-Wu/prompt-style.lua/actions/workflows/main.yml/badge.svg)](https://github.com/Freed-Wu/prompt-style.lua/actions)
[![codecov](https://codecov.io/gh/Freed-Wu/prompt-style.lua/branch/main/graph/badge.svg)](https://codecov.io/gh/Freed-Wu/prompt-style.lua)
[![DeepSource](https://deepsource.io/gh/Freed-Wu/prompt-style.lua.svg/?show_trend=true)](https://deepsource.io/gh/Freed-Wu/prompt-style.lua)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/prompt-style.lua/total)](https://github.com/Freed-Wu/prompt-style.lua/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/prompt-style.lua/latest/total)](https://github.com/Freed-Wu/prompt-style.lua/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)
[![github/v](https://shields.io/github/v/release/Freed-Wu/prompt-style.lua)](https://github.com/Freed-Wu/prompt-style.lua)

[![luarocks](https://img.shields.io/luarocks/v/Freed-Wu/prompt-style)](https://luarocks.org/modules/Freed-Wu)

[Powerlevel10k](https://github.com/romkatv/powerlevel10k) style for [luaprompt](https://github.com/dpapavas/luaprompt).

![screenshot](https://user-images.githubusercontent.com/32936898/255322845-c4c6e13c-3b39-4315-b09b-206a1a7783ea.png)

## Usage

```lua
local prompt = require "prompt"
local prompt_style = require "prompt-style"

prompt.prompts = { prompt_style.generate_ps1(), "    " }
```

## Customization

See
[![readthedocs](https://shields.io/readthedocs/prompt-stylelua)](https://prompt-stylelua.readthedocs.io).

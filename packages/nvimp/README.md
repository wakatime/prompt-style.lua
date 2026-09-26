# nvimp

![cmd](https://github.com/user-attachments/assets/26a34d2e-7db9-412c-beb3-87b8598294f9)

## Install

### rocks.nvim

#### Command style

```vim
:Rocks install nvimp
```

#### Declare style

`~/.config/nvim/rocks.toml`:

```toml
[plugins]
"nvimp" = "scm"
```

Then

```vim
:Rocks sync
```

or:

```sh
$ luarocks --lua-version 5.1 --local --tree ~/.local/share/nvim/rocks install nvimp
# ~/.local/share/nvim/rocks is the default rocks tree path
# you can change it according to your vim.g.rocks_nvim.rocks_path
```

## [Configure File](https://github.com/dpapavas/luaprompt)

`~/.config/nvim/init.lua`

## Alternatives

- [neolua](https://github.com/nvim-neorocks/neorocks): doesn't provide a REPL.
- [nlua](https://github.com/mfussenegger/nlua): doesn't provide a REPL.

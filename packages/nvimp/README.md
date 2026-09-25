# nvimp

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

## Alternatives

- [neolua](https://github.com/nvim-neorocks/neorocks): doesn't provide a REPL.
- [nlua](https://github.com/mfussenegger/nlua): doesn't provide a REPL.

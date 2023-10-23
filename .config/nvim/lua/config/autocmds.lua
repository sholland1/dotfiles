-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function createAutocmd(pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = "userGroup",
    pattern = pattern,
    command = command,
  })
end

vim.api.nvim_create_augroup("userGroup", { clear = true })

createAutocmd("*.lua", "luafile %")
createAutocmd(".zshrc", "!source %")
createAutocmd(".compton.conf", "!pkill picom;picom &")
createAutocmd("sxhkdrc", "!pkill sxhkd;sxhkd &")

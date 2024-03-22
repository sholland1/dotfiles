local function createAutocmd(pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("execOnWrite", { clear = true }),
    pattern = pattern,
    command = command,
  })
end

--createAutocmd("*.lua", "luafile %")
createAutocmd(".zshrc", "!source %")
createAutocmd(".compton.conf", "!pkill picom;picom &")
createAutocmd("sxhkdrc", "!pkill sxhkd;sxhkd &")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open all folds when opening a file',
  group = vim.api.nvim_create_augroup('postBufExec', { clear = true }),
  callback = function()
    vim.cmd('silent! :%foldopen!')
  end,
})

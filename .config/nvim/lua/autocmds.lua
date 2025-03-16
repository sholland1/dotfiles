local group = vim.api.nvim_create_augroup("execOnWrite", { clear = true })
local function createAutocmd(pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = pattern,
    command = command,
  })
end

createAutocmd(".zshrc", "!source %")
createAutocmd(".compton.conf", "!pkill picom;picom &")

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "sxhkdrc",
  callback = function()
    -- kill sxhkd and restart it with run-sxhkd command
    -- if there are errors on restart, display them
    local output = vim.fn.system("pkill sxhkd; run-sxhkd")
    vim.print(output)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.lua",
  callback = function()
    local file_path = vim.fn.expand("%:p")
    local dir_name = vim.fn.fnamemodify(file_path, ":p:h:t")
    local parent_dir = vim.fn.fnamemodify(file_path, ":p:h:h:t")

    -- only source if not a plugin file and in nvim folder
    if dir_name ~= "plugins" and parent_dir == "nvim" then
      vim.cmd('luafile %')
    end
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Reload the file if it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("reload", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  callback = Utils.trim_whitespace,
})

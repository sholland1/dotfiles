local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("utils")
require("options")
require("keymaps")
require("autocmds")

local lazy_opts = {
  change_detection = {
    notify = false,
  },
}
require("lazy").setup("plugins", lazy_opts)

-- disable notifications for pywal
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
    -- Replace 'pattern' with the message or pattern to ignore
    if msg and not msg:match("Change detected in template file*") then
        original_notify(msg, level, opts)
    end
end

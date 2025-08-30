vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"
vim.opt.mousescroll = "ver:8,hor:6"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.lazyredraw = true
vim.opt.shortmess = vim.opt.shortmess + 'I'
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 3000
vim.opt.wildignorecase = true
vim.o.background = nil
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

if vim.fn.has('win32') == 1 then
  vim.opt.shell = 'powershell'
  vim.opt.shellcmdflag = [[-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';]]
  vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.opt.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

-- set diagnostic icons
for type, icon in pairs(Utils.icons.diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

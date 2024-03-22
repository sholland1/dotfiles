-- Define a function to toggle the checkbox on the current line
local function toggleCheckbox()
  local current_line = vim.fn.line '.'
  local line_content = vim.fn.getline(current_line)

  -- Toggle the checkbox indicator by adding or removing "x"
  local updated_line = line_content:gsub('%[.-%]', function(match)
    return match == '[x]' and '[ ]' or '[x]'
  end)

  -- Update the line with the modified content
  vim.fn.setline(current_line, updated_line)
end

vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>t', toggleCheckbox, { desc = 'Toggle checkbox', silent = true })
vim.keymap.set('n', '<leader>q', '<C-w>q', { desc = 'Close window' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write' })
vim.keymap.set('n', '<leader>o', '<cmd>only<cr>', { desc = 'Only window' })
vim.keymap.set('n', '-', '<cmd>split<cr>', { desc = 'Horizontal split' })
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>');

vim.keymap.set('n', '<cr>', 'o<esc>')
vim.keymap.set('n', '<S-tab>', '<C-w>W')
vim.keymap.set('n', '<tab>', '<C-w>w')
vim.keymap.set('i', '<C-Backspace>', '<C-w>')

vim.keymap.set({ 'i', 'n', 'v' }, '<C-h>', '<cmd>bprev<cr>')
vim.keymap.set({ 'i', 'n', 'v' }, '<C-l>', '<cmd>bnext<cr>')
vim.keymap.set({ 'i', 'n', 'v' }, '<C-PageUp>', '<cmd>bprev<cr>')
vim.keymap.set({ 'i', 'n', 'v' }, '<C-PageDown>', '<cmd>bnext<cr>')

vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous [E]rror' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = '[E]rror window' })
--vim.keymap.set('n', '<C-.>', vim.diagnostic.setloclist, { desc = 'Quickfix' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy plugins' })


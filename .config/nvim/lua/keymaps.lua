vim.keymap.set('n', '<Plug>ToggleCheckbox', Utils.toggle_checkbox, { silent = true })
vim.keymap.set('n', '<leader>x', '<Plug>ToggleCheckbox', { desc = 'Toggle checkbox', silent = true })

vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>q', '<C-w>q', { desc = 'Close window' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write' })
vim.keymap.set('n', '<leader>o', '<cmd>only<cr>', { desc = 'Only window' })
vim.keymap.set('n', '-', '<cmd>split<cr>', { desc = 'Horizontal split' })
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })

local term_cmd = vim.fn.has('win32') == 1 and 'wt -d .' or '$TERM &'
vim.keymap.set({ 'i', 'n', 'v' }, '<C-cr>', '<cmd>silent !' .. term_cmd ..'<cr>', { desc = 'Open terminal in new window' })

local term_cmd_with_arg = vim.fn.has('win32') == 1 and
    'wt new-tab -d . powershell -c %s' or
    '$TERM -e %s &'
vim.keymap.set('n', '<leader>g',
  '<cmd>silent !' .. string.format(term_cmd_with_arg, 'lazygit') ..'<cr>',
  { desc = 'Open LazyGit' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search' })

vim.keymap.set('n', '<cr>', 'o<esc>', { desc = 'Insert new line below' })
vim.keymap.set('n', '<S-tab>', '<C-w>W', { desc = 'Previous window' })
vim.keymap.set('n', '<tab>', '<C-w>w', { desc = 'Next window' })
vim.keymap.set('i', '<C-Backspace>', '<C-w>', { desc = 'Delete previous word' })

vim.keymap.set({ 'i', 'n', 'v' }, '<C-h>', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set({ 'i', 'n', 'v' }, '<C-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set({ 'i', 'n', 'v' }, '<C-PageUp>', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set({ 'i', 'n', 'v' }, '<C-PageDown>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- fix <C-i>
vim.keymap.set('n', '<C-i>', '<C-i>', { remap = false })

vim.keymap.set('n', '<C-j>', 'mzyyp`zj', { desc = 'Duplicate line' })
vim.keymap.set('n', '<C-g>', '<cmd>Gitsigns preview_hunk_inline<cr>', { remap = false })
vim.keymap.set('n', '<M-m>', '<cmd>messages<cr>', { desc = 'Display Messages', remap = false })
vim.keymap.set('i', '<C-s>', '<cmd>wq<cr>', { remap = false })

vim.keymap.set('n', '<M-j>', 'mz:m+<cr>`z', { desc = 'Move line down' })
vim.keymap.set('n', '<M-k>', 'mz:m-2<cr>`z', { desc = 'Move line up' })
vim.keymap.set('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", { desc = 'Move line down' })
vim.keymap.set('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = 'Move line up' })

vim.keymap.set('c', '<M-j>', '<C-n>', { desc = 'Next completion' })
vim.keymap.set('c', '<M-k>', '<C-p>', { desc = 'Previous completion' })

vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous [E]rror' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = '[E]rror window' })

vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Go to previous [G]it hunk' })
vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Go to next [G]it hunk' })

vim.keymap.set({'n','v'}, '<leader>c', 'gc', { remap = true })
vim.keymap.set('n', '<leader>ku', 'gcgc', { remap = true })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy plugins' })

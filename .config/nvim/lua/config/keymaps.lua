-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Define a function to toggle the checkbox on the current line
local function toggleCheckbox()
  local current_line = vim.fn.line(".")
  local line_content = vim.fn.getline(current_line)

  -- Toggle the checkbox indicator by adding or removing "x"
  local updated_line
  if line_content:match("%[x%]") then
    updated_line = line_content:gsub("%[x%]", "[ ]")
  else
    updated_line = line_content:gsub("%[ %]", "[x]")
  end

  -- Update the line with the modified content
  vim.fn.setline(current_line, updated_line)
end

local keymap = vim.keymap.set
local command = vim.api.nvim_create_user_command

keymap("n", "<leader>d", "<cmd>bd<cr>", { desc = "Close Buffer" })
keymap("n", "<leader>t", toggleCheckbox, { desc = "Toggle Checkbox", noremap = true, silent = true })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Close Window" })
keymap("n", "<leader>v", "<cmd>Vifm fnameescape(expand('%:p:h')) fnameescape(getcwd())<cr>", { desc = "Open Vifm" })
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Write", remap = true })

keymap("n", "<leader>ww", "<nop>", { remap = true })
keymap("n", "<leader>wd", "<nop>", { remap = true })
keymap("n", "<leader>w-", "<nop>", { remap = true })
keymap("n", "<leader>w|", "<nop>", { remap = true })
--keymap("n", "<leader>c", "<nop>", { remap = true })

keymap("n", "<cr>", "o<esc>")
keymap("n", "s", "s")
keymap("n", "<S-tab>", "<C-w>W")
keymap("n", "<tab>", "<C-w>w")
keymap("n", "<C-v>", "<C-v>")

keymap("n", "H", "H", { remap = true })
keymap("n", "L", "L", { remap = true })
keymap({ "i", "n", "v" }, "<C-h>", "<cmd>bprev<cr>", { remap = true })
keymap({ "i", "n", "v" }, "<C-l>", "<cmd>bnext<cr>", { remap = true })
keymap({ "i", "n", "v" }, "<C-PageUp>", "<cmd>bprev<cr>", { remap = true })
keymap({ "i", "n", "v" }, "<C-PageDown>", "<cmd>bnext<cr>", { remap = true })

command("DeleteCurrentFile", "call delete(@%)|bd!", {})
command("MakeExecutable", "!chmod +x %", {})
command("TrimWhitespace", "%s/\\s\\+$//e", {})
command("RemoveExtraWhitespace", "%s/ \\{2,}/ /g", {})

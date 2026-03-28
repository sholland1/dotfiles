local function fkey_map()
  local key_map = {}
  local shift_prefix = vim.fn.has('win32') == 1 and '<S-F' or '<F'
  local index_offset = vim.fn.has('win32') == 1 and 0 or 12

  for i = 1, 12 do
    key_map['SF' .. i] = shift_prefix .. (index_offset + i) .. '>'
  end
  return key_map
end

Utils = {
  -- icons used by other plugins
  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    dap = {
      signs = {
        Stopped = "🡆 ",
        Breakpoint = "⬤ ",
        BreakpointCondition = " ",
        BreakpointRejected = " ",
        LogPoint = ".>",
      },
      controls = {
        pause = '⏸',
        play = '▶️',
        step_into = '⤵️',
        step_over = '⏭',
        step_out = '⏮',
        step_back = '🔙',
        run_last = '🔄',
        terminate = '🛑',
        disconnect = '⏏',
      },
      list = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '*',
      },
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
    git = {
      added    = " ",
      modified = " ",
      removed  = " ",
    },
    kinds = {
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Codeium       = "󰘦 ",
      Color         = " ",
      Control       = " ",
      Collapsed     = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Copilot       = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Folder        = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Keyword       = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      Reference     = " ",
      Snippet       = " ",
      String        = " ",
      Struct        = "󰆼 ",
      TabNine       = "󰏚 ",
      Text          = " ",
      TypeParameter = " ",
      Unit          = " ",
      Value         = " ",
      Variable      = "󰀫 ",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
  keys = fkey_map(),
}

local is_inside_work_tree = {} --cacheing the results of "git rev-parse"

function Utils.is_inside_work_tree()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end
  return is_inside_work_tree[cwd]
end

function Utils.telescope_wrapper(telescope_command, opts)
  return function()
    telescope_command(require("telescope.themes").get_ivy(opts))
  end
end

function Utils.is_onedrive_path(path)
  local file = path or vim.fn.expand('%:p')
  local onedrive_root = vim.fn.expand("~/OneDrive") .. "/"

  return file ~= "" and vim.startswith(file, onedrive_root)
end

function Utils.write_cmd(cmd)
  if Utils.is_onedrive_path() and not cmd:find("!", 1, true) then
    return cmd .. "!"
  end

  return cmd
end

function Utils.write_current_buffer()
  vim.cmd(Utils.write_cmd("write"))
end

function Utils.write_quit_current_buffer()
  vim.cmd(Utils.write_cmd("wq"))
end

-- Function to toggle the checkbox on the current line
function Utils.toggle_checkbox()
  local current_line = vim.fn.line '.'
  local line_content = vim.fn.getline(current_line)

  -- Toggle the checkbox indicator by adding or removing "x"
  local updated_line = line_content:gsub('%[.-%]', function(match)
    return match == '[x]' and '[ ]' or '[x]'
  end)

  -- Update the line with the modified content
  vim.fn.setline(current_line, updated_line)
  -- Make the action repeatable
  vim.fn['repeat#set'](vim.api.nvim_replace_termcodes('<Plug>ToggleCheckbox', true, true, true))
  -- Write the changes to the file
  if vim.fn.expand('%') ~= '' then
    Utils.write_current_buffer()
  end
end

-- Function to remove trailing whitespace
function Utils.trim_whitespace()
  local save = vim.fn.winsaveview()
  vim.cmd[[%s/\s\+$//e]]
  vim.fn.winrestview(save)
end


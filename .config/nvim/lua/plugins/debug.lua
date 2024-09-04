return {
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      --'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'codelldb',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', Utils.keys.SF5, dap.terminate, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', Utils.keys.SF11, dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', Utils.keys.SF9, function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = Utils.icons.dap.list,
        controls = {
          icons = Utils.icons.dap.controls,
        },
        adapters = {
          lldb = {
            type = 'executable',
            command = '/usr/bin/lldb-vscode',
            name = 'lldb',
          },

        },
      }

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939'})
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#587539'})
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#92744a'})
      vim.api.nvim_set_hl(0, 'DapHighlightLine', { ctermbg = 0, bg = '#c4c8da' })

      local icons = Utils.icons.dap.signs
      vim.fn.sign_define('DapBreakpoint', { text=icons.Breakpoint, texthl='DapBreakpoint', linehl='DapHighlightLine', numhl='DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition', { text=icons.BreakpointCondition, texthl='DapBreakpoint', linehl='DapHighlightLine', numhl='DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected', { text=icons.BreakpointRejected, texthl='DapBreakpoint', linehl='DapHighlightLine', numhl= 'DapBreakpoint' })
      vim.fn.sign_define('DapLogPoint', { text=icons.LogPoint, texthl='DapLogPoint', linehl='DapHighlightLine', numhl= 'DapLogPoint' })
      vim.fn.sign_define('DapStopped', { text=icons.Stopped, texthl='DapStopped', linehl='DapHighlightLine', numhl= 'DapStopped' })
    end,
  },

--  {
--    "mrcjkb/rustaceanvim",
--    version = '^4',
--    ft = { 'rust' },
--  },
}

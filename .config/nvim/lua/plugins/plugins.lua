return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-day'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    config = function()
      vim.keymap.set('n', '\\T', '<cmd>TodoTelescope theme=ivy<cr>', { desc = 'Search TODOs' })
      require('todo-comments').setup()
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'echasnovski/mini.bufremove',
    keys = {
      { "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = Utils.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(require("bufferline").nvim_bufferline)
          end)
        end,
      })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function multiopen(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          local multi = picker:get_multi_selection()

          if vim.tbl_isempty(multi) then
              actions.select_default(prompt_bufnr)
              return
          end

          actions.close(prompt_bufnr)
          for _, entry in pairs(multi) do
              local filename = entry.filename or entry.value
              local lnum = entry.lnum or 1
              local lcol = entry.col or 1
              if filename then
                  vim.cmd("edit " .. filename)
                  vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
              end
          end
      end

      require('telescope').setup {
        defaults = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<M-j>"] = actions.move_selection_next,
              ["<M-k>"] = actions.move_selection_previous,

              ["<M-h>"] = actions.results_scrolling_left,
              ["<M-l>"] = actions.results_scrolling_right,
              ["<Left>"] = actions.results_scrolling_left,
              ["<Right>"] = actions.results_scrolling_right,
              ["<C-d>"] = actions.results_scrolling_down,
              ["<C-u>"] = actions.results_scrolling_up,

              ["<M-Down>"] = actions.preview_scrolling_down,
              ["<M-Up>"] = actions.preview_scrolling_up,
              ["<M-Left>"] = actions.preview_scrolling_left,
              ["<M-Right>"] = actions.preview_scrolling_right,
              ["<esc>"] = actions.close,

              ["<C-a>"] = actions.select_all,
              ["<C-z>"] = actions.drop_all,

              ["<CR>"] = multiopen,
            },
            n = {
              ["<CR>"] = multiopen,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_cursor(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      local function my_find_files(opts)
        local extra_opts = {}
        if vim.fn.getcwd() == vim.fn.expand '$HOME' then
          extra_opts = {
            find_command = { "git", "ls-files" },
            prompt_title = 'Search Dotfiles',
          }
        elseif Utils.is_inside_work_tree() then
          extra_opts = {
            find_command = { 'rg', '--files', '--sort=path', '--hidden' },
          }
        end
        for k, v in pairs(extra_opts) do
          opts[k] = v
        end
        builtin.find_files(opts)
      end

      vim.keymap.set('n', '\\h', Utils.telescope_wrapper(builtin.help_tags), { desc = 'Search Help' })
      vim.keymap.set('n', '\\k', Utils.telescope_wrapper(builtin.keymaps), { desc = 'Search Keymaps' })
      vim.keymap.set('n', '\\f', Utils.telescope_wrapper(my_find_files), { desc = 'Search Files' })
      vim.keymap.set('n', '\\t', Utils.telescope_wrapper(builtin.builtin), { desc = 'Search Telescope Builtins' })
      vim.keymap.set('n', '\\w', Utils.telescope_wrapper(builtin.grep_string), { desc = 'Search Current Word' })
      vim.keymap.set('n', '\\g', Utils.telescope_wrapper(builtin.live_grep), { desc = 'Grep Current Directory' })
      vim.keymap.set('n', '\\d', Utils.telescope_wrapper(builtin.diagnostics), { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '\\\\', Utils.telescope_wrapper(builtin.resume), { desc = 'Resume Previous Search' })
      vim.keymap.set('n', '\\r', Utils.telescope_wrapper(builtin.oldfiles), { desc = 'Search Recent Files' })
      vim.keymap.set('n', '\\b', Utils.telescope_wrapper(builtin.buffers), { desc = 'Search Open Buffers' })
      vim.keymap.set('n', '\\C', Utils.telescope_wrapper(builtin.commands), { desc = 'Search Neovim Commands' })

      vim.keymap.set('n', '\\/',
        Utils.telescope_wrapper(builtin.current_buffer_fuzzy_find, { previewer = false }),
        { desc = 'Search Current Buffer' })

      vim.keymap.set('n', '\\o',
        Utils.telescope_wrapper(builtin.live_grep,
          { grep_open_files = true, prompt_title = 'Grep Open Files' }),
        { desc = 'Grep Open Files' })

      vim.keymap.set('n', '\\c',
        Utils.telescope_wrapper(builtin.find_files, { cwd = vim.fn.stdpath 'config' }),
        { desc = 'Search Neovim Config Files' })
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'html', 'markdown', 'toml', 'xml',
        'vim', 'vimdoc',
        'bash',
        'c', 'c_sharp', 'lua', 'python', 'rust'
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      vim.keymap.set('n', '<leader>ts', '<cmd>TSInstallInfo<cr>', { desc = 'Treesitter' })
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

      -- Setup folding
      vim.opt.foldlevelstart = 99
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require 'telescope.builtin'
          map('<F12>', Utils.telescope_wrapper(builtin.lsp_definitions), 'Go to Definition')
          map(Utils.keys.SF12, Utils.telescope_wrapper(builtin.lsp_references), 'Go to References')
          map('gI', Utils.telescope_wrapper(builtin.lsp_implementations), '[G]o to [I]mplementation')
          map('<leader>D', Utils.telescope_wrapper(builtin.lsp_type_definitions), 'Type [D]efinition')
          map('<leader>fs', Utils.telescope_wrapper(builtin.lsp_document_symbols), '[F]ile [S]ymbols')
          map('<leader>ps', Utils.telescope_wrapper(builtin.lsp_dynamic_workspace_symbols), '[P]roject [S]ymbols')
          map('<F2>', vim.lsp.buf.rename, 'Rename')
          -- map('<C-.>', vim.lsp.buf.code_action, 'Code Action') -- defined below (actions-preview)
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        --INFO: add an omnisharp.json file to the sln for additional features
        -- {
        -- /* display additional analysis */
        --  "RoslynExtensionsOptions": {
        --    "enableAnalyzersSupport": true
        --  },
        -- /* ability to use .editorconfig file */
        --  "FormattingOptions": {
        --    "enableEditorConfigSupport": true
        --  },
        -- /* rename in more places */
        --  "RenameOptions": {
        --    "RenameInComments": true,
        --    "RenameOverloads": true,
        --    "RenameInStrings": true
        --  }
        --}

        omnisharp = {
          capabilities = capabilities,
          enable_roslyn_analyzers = true,
          enable_import_completion = true,
          organize_imports_on_format = true,
          enable_decompilation_support = true,
          filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
              diagnostics = { globals = { 'vim' }},
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()
      vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>', { desc = 'Mason' })

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<M-j>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<M-k>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<Tab>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      local copilot = require('copilot.suggestion')
      vim.keymap.set('i', '<M-l>', copilot.accept_word, { desc = 'Accept word' })
      vim.keymap.set('i', '<M-;>', copilot.accept, { desc = 'Accept suggestion' })
    end,
  },

  {
    "vifm/vifm.vim",
    config = function()
      local function vifm_command()
        if vim.fn.has('win32') == 1 then
          vim.cmd('Vifm')
          return
        end

        -- open current file on the left
        local left_pane = vim.fn.expand('%:p:h')

        -- if in a git repo, open the repo root
        -- otherwise, open the home directory
        local right_pane = Utils.is_inside_work_tree()
          and vim.fn.system('git rev-parse --show-toplevel')
          or vim.fn.expand('$HOME')

        vim.cmd('Vifm ' .. left_pane .. ' ' .. right_pane)
      end
      vim.keymap.set('n', '<leader>v', vifm_command, { desc = 'Open Vifm' })
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    config = function()
      vim.keymap.set('n', '<leader>g', require('lazygit').lazygit, { desc = 'Open LazyGit' })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },
  -- { "echasnovski/mini.statusline", config = true, },
  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "chrisgrieser/nvim-genghis",
    config = function()
      -- maybe use tpope/vim-eunuch instead
      local genghis = require("genghis")

      vim.api.nvim_create_user_command("Rename", function() genghis.renameFile() end, {})
      vim.api.nvim_create_user_command("Trash", function() genghis.trashFile() end, {})
    end,
  },

  {
    "MoaidHathot/dotnet.nvim",
    config = function()
      local dotnet = require("dotnet")
      dotnet.setup({})

      local opts = dotnet.opts
      local ui = require("dotnet.ui.ui")
      vim.api.nvim_create_user_command("DotnetNewProject", function () ui.open_project_creation_window(opts) end, {})
      vim.api.nvim_create_user_command("DotnetAddNugetPackage", function () ui.open_add_package_window(opts) end, {})
      vim.api.nvim_create_user_command("DotnetRemoveNugetPackage", function () ui.open_remove_package_window(opts) end, {})
      vim.api.nvim_create_user_command("DotnetAddReference", function () ui.open_add_project_reference_window(opts) end, {})
      vim.api.nvim_create_user_command("DotnetRemoveReference",  function () ui.open_remove_project_reference_window(opts) end, {})
    end
  },

  {
    "aznhe21/actions-preview.nvim",
    config = function()
      local ap = require("actions-preview")
      vim.keymap.set({'v', 'n'}, "<C-.>", ap.code_actions, { desc = 'Code Action' })
      ap.setup({
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      })
    end,
  },

  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
      vim.keymap.set('n', '<F6>', "<cmd>OverseerRun<cr>", { desc = 'Tasks' })
      vim.keymap.set('n', Utils.keys.SF6, "<cmd>OverseerToggle<cr>", { desc = 'Toggle Tasks' })
    end
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    build =
      vim.fn.has("win32") == 0 and "make" or
        "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("avante").setup({
        provider = "openai",
      })
    end,
  },

  "lambdalisue/suda.vim",
  "tpope/vim-sleuth",
  "nvim-tree/nvim-web-devicons",
  "tpope/vim-obsession",
  "tridactyl/vim-tridactyl",
  "kyoh86/vim-jsonl",
  "baskerville/vim-sxhkdrc",
  "h-hg/fcitx.nvim",
}

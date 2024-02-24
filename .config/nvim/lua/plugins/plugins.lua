return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          mason = false,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local actions = require("telescope.actions")
      return {
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

              ["<M-Down>"] = actions.preview_scrolling_down,
              ["<M-Up>"] = actions.preview_scrolling_up,
              ["<M-Left>"] = actions.preview_scrolling_left,
              ["<M-Right>"] = actions.preview_scrolling_right,
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    enabled = true,
    config = function()
      local stages = require("notify.stages.slide")("top_down")
      local notify = require("notify")

      local my_config = {
        render = "compact",
        stages = {
          function(...)
            local opts = stages[1](...)
            if opts then
              opts.border = "none"
              opts.row = opts.row + 1
            end
            return opts
          end,
          unpack(stages, 2),
        },
        timeout = 2000,
      }

      notify.setup(my_config)
    end,
  },
  { "folke/flash.nvim", enabled = false },
  { "vifm/vifm.vim" },
  { "tpope/vim-obsession" },
  { "chrisgrieser/nvim-genghis" },
}

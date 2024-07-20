return {
  {
    'stevearc/oil.nvim',
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      local oil = require 'oil'

      oil.setup {
        columns = { 'icon' },
        skip_confirm_for_simple_edits = true,

        keymaps = {
          ['<C-s>'] = false,
          ['<C-e>'] = 'actions.select_split',
          ['<C-h>'] = false,
          ['<C-p>'] = false,
          ['<C-t>'] = 'actions.preview',
          ['.'] = 'actions.toggle_hidden',
        },

        float = {
          padding = 10,
          max_width = 150,
          win_options = {
            winblend = 0,
          },
        },
      }

      vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Oil" })
      vim.keymap.set("n", "<leader>of", oil.toggle_float, { desc = "Oil floating window" })
      vim.keymap.set("n", "<leader>o~", function()
        oil.toggle_float "~"
      end, { desc = "Oil float ~" })
    end,
  },
}

return {
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "rose-pine"
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
    },
  },

  { "dmmulroy/tsc.nvim", opts = {} },

  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {},
  --   init = function()
  --     vim.keymap.set("n", "<leader>ts", vim.cmd.TailwindSort)
  --   end,
  -- },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  {
    "echasnovski/mini.icons",
    version = false,
    opts = {},
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      local ss = require "smart-splits"
      vim.keymap.set("n", "<A-H>", ss.resize_left)
      vim.keymap.set("n", "<A-J>", ss.resize_down)
      vim.keymap.set("n", "<A-K>", ss.resize_up)
      vim.keymap.set("n", "<A-L>", ss.resize_right)

      vim.keymap.set("n", "<A-h>", ss.move_cursor_left)
      vim.keymap.set("n", "<A-j>", ss.move_cursor_down)
      vim.keymap.set("n", "<A-k>", ss.move_cursor_up)
      vim.keymap.set("n", "<A-l>", ss.move_cursor_right)
      vim.keymap.set("n", "<A-/>", ss.move_cursor_previous)
      -- swapping buffers between windows
      vim.keymap.set("n", "<leader><leader>h", ss.swap_buf_left)
      vim.keymap.set("n", "<leader><leader>j", ss.swap_buf_down)
      vim.keymap.set("n", "<leader><leader>k", ss.swap_buf_up)
      vim.keymap.set("n", "<leader><leader>l", ss.swap_buf_right)
    end,
  },
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  checker = { enabled = false },
  change_detection = { notify = false },
  rocks = { enabled = false },
  spec = {
    { import = "plugins" },
    "tpope/vim-sleuth",

    {
      "stevearc/oil.nvim",
      dependencies = { "echasnovski/mini.icons" },
      opts = {
        columns = { "icon" },
        skip_confirm_for_simple_edits = true,
        view_options = { show_hidden = true },
        keymaps = {
          ["<C-s>"] = false,
          ["<C-e>"] = "actions.select_vsplit",
          ["<C-h>"] = false,
          ["<C-p>"] = false,
          ["<C-t>"] = "actions.preview",
          ["."] = "actions.toggle_hidden",
        },
        float = {
          padding = 10,
          max_width = 150,
          win_options = {
            winblend = 0,
          },
        },
      },
      init = function()
        vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Oil" })
        vim.keymap.set("n", "<leader>of", require("oil").toggle_float, { desc = "Oil floating window" })
        vim.keymap.set("n", "<leader>o~", function()
          require("oil").toggle_float "~"
        end, { desc = "Oil float ~" })
      end,
    },
    {
      "mbbill/undotree",
      init = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      end,
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
      "echasnovski/mini.splitjoin",
      version = false,
      opts = {
        mappings = { toggle = "<leader>S" },
      },
    },
    { "echasnovski/mini.surround", version = false, opts = {} },

    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      opts = {},
      init = function()
        vim.keymap.set("n", "<leader>q", function()
          require("quicker").toggle { focus = true, height = 8 }
        end)
        vim.keymap.set("n", "<leader>l", function()
          require("quicker").toggle { focus = true, height = 8, loclist = true }
        end)
        vim.keymap.set("n", ">", function()
          require("quicker").toggle_expand { before = 3, after = 3, add_to_existing = true }
        end)
      end,
    },

    {
      "savq/melange-nvim",
      lazy = false,
      priority = 1000,
      init = function()
        vim.cmd.colorscheme "melange"
      end,
    },
    {
      "brenoprata10/nvim-highlight-colors",
      opts = {
        render = "virtual",
        virtual_symbol_suffix = "",
      },
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
  },
}

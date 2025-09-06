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
    "mbbill/undotree",
    "savq/melange-nvim",
    -- { "brenoprata10/nvim-highlight-colors", opts = { render = "virtual", virtual_symbol_suffix = "" } },
    { "saghen/blink.cmp", dependencies = "rafamadriz/friendly-snippets", version = "*" },
    { "nvim-mini/mini.icons", version = false, opts = {} },
    { "nvim-mini/mini.surround", version = false, opts = {} },
    { "stevearc/quicker.nvim", event = "FileType qf", opts = {} },
    "stevearc/oil.nvim",
    "mrjones2014/smart-splits.nvim",
    { "theprimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },

    { import = "plugins" },
  },
}

require "oil".setup {
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
    padding = 5,
    max_width = 150,
    win_options = { winblend = 0 },
  },
}

require "blink-cmp".setup {
  signature = { enabled = true },
  cmdline = {
    keymap = {
      ["<Tab>"] = {},
    },
  },
  completion = {
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = false } },
    menu = {
      auto_show = function(ctx)
        local ft = vim.o.ft
        return ctx.mode ~= "cmdline" and ft ~= "go" and ft ~= "rust"
      end,
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
      },
    },
  },
}

vim.keymap.set("n", "<C-h>", function()
  require "harpoon".ui:toggle_quick_menu(require "harpoon":list(), {
    border = "rounded",
    ui_width_ratio = 0.4,
  })
end)
vim.keymap.set("n", "<leader>a", function() require "harpoon":list():add() end)
vim.keymap.set("n", "<C-j>", function() require "harpoon":list():select(1) end)
vim.keymap.set("n", "<C-k>", function() require "harpoon":list():select(2) end)
vim.keymap.set("n", "<C-l>", function() require "harpoon":list():select(3) end)
vim.keymap.set("n", "<C-;>", function() require "harpoon":list():select(4) end)
vim.keymap.set("n", "<C-p>", function() require "harpoon":list():select(5) end)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set("n", "<leader>of", function() require "oil".toggle_float() end)
vim.keymap.set("n", "<leader>o~", function() require "oil".toggle_float "~" end)

vim.keymap.set("n", "<leader>q", function()
  require("quicker").toggle { focus = true, height = 8 }
end)
vim.keymap.set("n", "<leader>l", function()
  require("quicker").toggle { focus = true, height = 8, loclist = true }
end)
vim.keymap.set("n", ">", function()
  require("quicker").toggle_expand { before = 3, after = 3, add_to_existing = true }
end)

vim.keymap.set("n", "<A-H>", function() require "smart-splits".resize_left() end)
vim.keymap.set("n", "<A-J>", function() require "smart-splits".resize_down() end)
vim.keymap.set("n", "<A-K>", function() require "smart-splits".resize_up() end)
vim.keymap.set("n", "<A-L>", function() require "smart-splits".resize_right() end)
vim.keymap.set("n", "<A-h>", function() require "smart-splits".move_cursor_left() end)
vim.keymap.set("n", "<A-j>", function() require "smart-splits".move_cursor_down() end)
vim.keymap.set("n", "<A-k>", function() require "smart-splits".move_cursor_up() end)
vim.keymap.set("n", "<A-l>", function() require "smart-splits".move_cursor_right() end)
vim.keymap.set("n", "<A-/>", function() require "smart-splits".move_cursor_previous() end)

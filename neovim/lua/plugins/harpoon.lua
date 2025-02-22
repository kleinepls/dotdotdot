return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<C-h>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = "rounded",
        title_pos = "center",
        ui_width_ratio = 0.4,
      })
    end)

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-j>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-k>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-l>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-;>", function()
      harpoon:list():select(4)
    end)
    vim.keymap.set("n", "<C-p>", function()
      harpoon:list():select(5)
    end)
  end,
}

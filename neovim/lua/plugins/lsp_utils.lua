return {
  { "dmmulroy/tsc.nvim", opts = {} },
  { "j-hui/fidget.nvim", opts = {} },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {
      max_width = 80,
    },
    init = function()
      vim.keymap.set("n", "K", require("pretty_hover").hover)
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    init = function()
      vim.keymap.set("n", "<leader>tp", "<cmd>Trouble diagnostics toggle focus<cr>")
      vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle focus filter.buf=0<cr>")

      vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus<cr>")

      vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle focus<cr>")

      vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle win.position=bottom<cr>")
    end,
  },
}

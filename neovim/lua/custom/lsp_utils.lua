vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float)

vim.diagnostic.config {
  signs = false,
  float = {
    border = "rounded",
    source = true,
  },
}

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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    opts = {},
    init = function()
      local virtual_text = true

      vim.keymap.set("n", "<leader>dg", function()
        require("lsp_lines").toggle()

        virtual_text = not virtual_text
        vim.diagnostic.config {
          virtual_text = virtual_text,
        }
      end)

      vim.diagnostic.config {
        virtual_lines = false,
      }
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

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
}

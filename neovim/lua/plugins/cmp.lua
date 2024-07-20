return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
  },

  config = function()
    vim.opt.shortmess:append "c"
    vim.opt.completeopt = "menuone,noselect,preview"

    local lspkind = require "lspkind"
    local cmp = require "cmp"

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          -- maxwidth = 50,

          ellipsis_char = "...",
          show_labelDetails = true,
        },
      },

      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            select = true,
          },
          { "i", "c" }
        ),
        ["<C-Space>"] = cmp.mapping.complete {},

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
    }
  end,
}

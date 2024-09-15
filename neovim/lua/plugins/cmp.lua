return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-calc",
    "onsails/lspkind.nvim",
  },

  config = function()
    vim.opt.shortmess:append "c"
    vim.opt.completeopt = "menuone,noselect,preview"

    local hl_colors = require "nvim-highlight-colors"
    local lspkind = require "lspkind"
    local cmp = require "cmp"

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = function(entry, item)
          local color_item = hl_colors.format(entry, { kind = item.kind })

          item = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 30,
            ellipsis_char = "...",
            show_labelDetails = true,
            menu = {
              buffer = "[Buffer]",
              calc = "[Calc]",
              luasnip = "[LuaSnip]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              path = "[Path]",
            },
          }(entry, item)

          item.kind_hl_group = color_item.abbr_hl_group

          return item
        end,
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
        { name = "nvim_lsp", group_index = 1 },
        { name = "calc", group_index = 2 },
        { name = "buffer", group_index = 3 },
      },
    }
  end,
}

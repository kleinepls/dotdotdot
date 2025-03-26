return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    signature = { enabled = true },
    appearance = {
      nerd_font_variant = "mono",
      use_nvim_cmp_as_default = true,
    },

    cmdline = {
      keymap = {
        ["<Tab>"] = {},
      },
    },

    completion = {
      documentation = { auto_show = true },

      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,

        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
        },
      },
    },
  },
}

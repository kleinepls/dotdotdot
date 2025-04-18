return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    signature = { enabled = true },
    appearance = { use_nvim_cmp_as_default = true },
    cmdline = {
      keymap = {
        ["<Tab>"] = {},
      },
    },
    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = false } },

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

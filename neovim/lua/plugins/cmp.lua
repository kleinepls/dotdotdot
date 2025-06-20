return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    signature = { enabled = true },
    cmdline = {
      keymap = {
        ["<Tab>"] = {},
      },
    },
    completion = {
      documentation = { auto_show = true },
      -- ghost_text = { enabled = true },
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
  },
}

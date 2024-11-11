return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        -- transparency = true,
      },
      palette = {
        main = {
          base = "#000000",
        },
      },
    },
    init = function()
      vim.cmd.colorscheme "rose-pine"
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol_suffix = "",
    },
  },
}

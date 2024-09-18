return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
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

return {
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "melange"
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

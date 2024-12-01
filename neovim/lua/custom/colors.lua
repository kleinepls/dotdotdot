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

      highlight_groups = {
        StatusLine = { bg = "#191919" },
        StatusLineNC = { bg = "#191919" },
        WinBar = { bg = "#000000" },
        WinBarNC = { bg = "#000000" },
      },

      groups = {
        link = "gold",
        git_add = "#9CE0B3",
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

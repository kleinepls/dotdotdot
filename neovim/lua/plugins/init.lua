return {
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'mrjones2014/smart-splits.nvim',

  { 
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000, 
    config = function()
      vim.cmd.colorscheme "rose-pine"
    end
  },

  {
    'echasnovski/mini.icons',
    version = false,
    opts = {},
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}

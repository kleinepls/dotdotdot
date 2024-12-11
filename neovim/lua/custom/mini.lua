return {
  {
    "echasnovski/mini.ai",
    opts = function()
      local ai = require "mini.ai"
      return {
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
        },
      }
    end,
  },

  {
    "echasnovski/mini.icons",
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

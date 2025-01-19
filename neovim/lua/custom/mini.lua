return {
  {
    "echasnovski/mini.ai",
    version = false,
    opts = function()
      local ai = require "mini.ai"
      return {
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
        },
        search_method = "cover_or_nearest",
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

  {
    "echasnovski/mini.splitjoin",
    version = false,
    opts = {
      mappings = { toggle = "<leader>S" },
    },
  },

  { "echasnovski/mini.surround", version = false, opts = {} },
}

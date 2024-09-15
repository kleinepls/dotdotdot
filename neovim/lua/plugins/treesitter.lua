return {
  { "windwp/nvim-ts-autotag", lazy = false, opts = {} },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "css",
          "go",
          "html",
          "javascript",
          "lua",
          "rust",
          "tsx",
          "typescript",
          "vimdoc",
          "vim",
          "vue",
        },
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<C-Z>",
          },
        },

        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>z"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>Z"] = "@parameter.inner",
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local ctx = require "treesitter-context"
      ctx.setup { max_lines = 3 }
      vim.keymap.set("n", "[c", ctx.go_to_context, { silent = true })
    end,
  },
}

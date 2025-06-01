return {
  { "windwp/nvim-ts-autotag", lazy = false, opts = {} },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "css",
          "go",
          "html",
          "javascript",
          "lua",
          "markdown_inline",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        highlight = { enable = true, additional_vim_regex_highlighting = false },
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
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },

          swap = {
            enable = true,
            swap_next = {
              ["]z"] = "@parameter.inner",
            },
            swap_previous = {
              ["]x"] = "@parameter.inner",
            },
          },

          move = {
            enable = true,
            -- set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 3 },
    init = function()
      vim.keymap.set("n", "[c", require("treesitter-context").go_to_context, { silent = true })
    end,
  },
}

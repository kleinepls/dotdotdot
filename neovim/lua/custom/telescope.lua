return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
  },
  config = function()
    local telescope = require "telescope"
    local builtin = require "telescope.builtin"
    local utils = require "telescope.utils"
    local themes = require "telescope.themes"

    telescope.setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    telescope.load_extension "fzf"
    telescope.load_extension "ui-select"

    vim.keymap.set("n", "<leader>fp", builtin.git_files)
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fc", builtin.commands)
    vim.keymap.set("n", "<leader>fs", builtin.builtin)
    vim.keymap.set("n", "<leader>fm", builtin.man_pages)
    vim.keymap.set("n", "<leader>?", builtin.oldfiles)
    vim.keymap.set("n", "<leader>fr", builtin.resume)
    vim.keymap.set("n", "<leader>fk", builtin.keymaps)
    vim.keymap.set("n", "<leader>fq", builtin.quickfix)

    vim.keymap.set("n", "<leader>fw", function()
      local word = vim.fn.expand "<cword>"
      builtin.grep_string { search = word, prompt_title = "word: " .. word }
    end)

    vim.keymap.set("n", "<leader>af", function()
      builtin.find_files { cwd = utils.buffer_dir(), prompt_title = utils.buffer_dir() }
    end)
    vim.keymap.set("n", "<leader>ag", function()
      builtin.live_grep { cwd = utils.buffer_dir(), prompt_title = utils.buffer_dir() }
    end)

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = builtin.file_browser })
    end)

    -- misc
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files { cwd = "~/dotfiles/neovim", prompt_title = "~/dotfiles/neovim" }
    end)

    -- git
    vim.keymap.set("n", "<leader>gc", builtin.git_commits)
    vim.keymap.set("n", "<leader>gh", builtin.git_bcommits)
    vim.keymap.set("n", "<leader>gb", builtin.git_branches)
    vim.keymap.set("n", "<leader>gt", builtin.git_status)
    vim.keymap.set("n", "<leader>gx", builtin.git_stash)
  end,
}

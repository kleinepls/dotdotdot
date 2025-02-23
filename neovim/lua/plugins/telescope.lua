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
      defaults = {
        path_display = { "truncate" },
      },

      pickers = {
        grep_string = { initial_mode = "normal" },
        resume = { initial_mode = "normal" },
        quickfix = { initial_mode = "normal" },
        oldfiles = { initial_mode = "normal" },
        lsp_references = { initial_mode = "normal" },
        lsp_definitions = { initial_mode = "normal" },
        lsp_implementations = { initial_mode = "normal" },
      },

      extensions = {
        ["ui-select"] = {
          themes.get_dropdown(),
        },
      },
    }

    telescope.load_extension "fzf"
    telescope.load_extension "ui-select"

    vim.keymap.set("n", "<leader>ff", builtin.git_files)
    vim.keymap.set("n", "<leader>fp", builtin.find_files)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fc", builtin.commands)
    vim.keymap.set("n", "<leader>fs", builtin.builtin)
    vim.keymap.set("n", "<leader>fm", builtin.marks)
    vim.keymap.set("n", "<leader>fa", builtin.man_pages)
    vim.keymap.set("n", "<leader>?", builtin.oldfiles)
    vim.keymap.set("n", "<leader>fr", builtin.registers)
    vim.keymap.set("n", "<leader>fe", builtin.resume)
    vim.keymap.set("n", "<leader>fk", builtin.keymaps)
    vim.keymap.set("n", "<leader>fq", builtin.quickfix)

    vim.keymap.set("n", "<leader>G", builtin.live_grep)
    vim.keymap.set("n", "<leader>fg", function()
      local input = vim.fn.input "Grep > "
      if input ~= "" then
        builtin.grep_string { search = input, prompt_title = input }
      end
    end)

    vim.keymap.set("n", "<leader>fw", function()
      local word = vim.fn.expand "<cword>"
      if word == "" then
        builtin.live_grep()
        return
      end
      builtin.grep_string { search = word, prompt_title = word }
    end)

    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
    vim.keymap.set("n", "<leader>f/", function()
      local word = vim.fn.expand "<cword>"
      builtin.current_buffer_fuzzy_find()
      if word ~= "" then
        vim.fn.feedkeys(word)
        -- doesn't work without deferring
        vim.defer_fn(vim.cmd.stopinsert, 0)
      end
    end)

    vim.keymap.set("n", "<leader>af", function()
      builtin.find_files { cwd = utils.buffer_dir(), prompt_title = utils.buffer_dir() }
    end)
    vim.keymap.set("n", "<leader>ag", function()
      builtin.live_grep { cwd = utils.buffer_dir(), prompt_title = utils.buffer_dir() }
    end)

    -- misc
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files { cwd = "~/dotfiles", prompt_title = "~/dotfiles" }
    end)

    -- git
    vim.keymap.set("n", "<leader>gc", builtin.git_commits)
    vim.keymap.set("n", "<leader>gh", builtin.git_bcommits)
    vim.keymap.set("n", "<leader>gb", builtin.git_branches)
    vim.keymap.set("n", "<leader>gt", builtin.git_status)
    vim.keymap.set("n", "<leader>gx", builtin.git_stash)
  end,
}

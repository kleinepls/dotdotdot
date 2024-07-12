return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- 'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.icons',
  },
  config = function()
    local telescope = require('telescope');
    local builtin = require('telescope.builtin');
    local utils = require('telescope.utils');
    local themes = require('telescope.themes');

    telescope.setup({
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
      },
    });

    telescope.load_extension('fzf');

    -- main keymaps
    vim.keymap.set('n', '<C-n>', builtin.git_files, { desc = '[Telescope] Search Git files' })
    vim.keymap.set('n', '<leader>pf', builtin.find_files);
    vim.keymap.set('n', '<leader>pg', builtin.live_grep);
    vim.keymap.set('n', '<leader>pc', builtin.commands)
    vim.keymap.set('n', '<leader>pm', builtin.man_pages)
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[Telescope] Find recently opened files' })
    vim.keymap.set('n', '<leader>pr', builtin.resume, { desc = '[Telescope] Search Resume' })
    vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = '[Telescope] Search Keymaps' })
    vim.keymap.set('n', '<leader>pq', builtin.quickfix, { desc = '[Telescope] Search Quickfix' })

    vim.keymap.set('n', '<leader>af', function() builtin.find_files({ cwd = utils.buffer_dir() }); end);
    vim.keymap.set('n', '<leader>ag', function() builtin.live_grep({ cwd = utils.buffer_dir() }); end);
    vim.keymap.set('n', '<leader>pw', function() builtin.grep_string({ search = vim.fn.expand '<cword>' }) end)

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = builtin.file_browser, })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- misc
    vim.keymap.set('n', '<leader>pn', function() builtin.find_files({ cwd = '~/dotfiles/neovim' }); end);
  end,
}

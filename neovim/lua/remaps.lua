vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set('n', '<Enter>', '<nop>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', '<', '<gv', { noremap = true, silent = false })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = false })

-- yanking, deleting
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>c', '"_c')

-- tabs
vim.keymap.set('n', 'TN', vim.cmd.tabnext)
vim.keymap.set('n', 'TP', vim.cmd.tabprevious)
vim.keymap.set('n', 'TX', vim.cmd.tabclose)


local ss = require('smart-splits')
vim.keymap.set('n', '<A-H>', ss.resize_left)
vim.keymap.set('n', '<A-J>', ss.resize_down)
vim.keymap.set('n', '<A-K>', ss.resize_up)
vim.keymap.set('n', '<A-L>', ss.resize_right)

vim.keymap.set('n', '<A-h>', ss.move_cursor_left)
vim.keymap.set('n', '<A-j>', ss.move_cursor_down)
vim.keymap.set('n', '<A-k>', ss.move_cursor_up)
vim.keymap.set('n', '<A-l>', ss.move_cursor_right)
vim.keymap.set('n', '<A-/>', ss.move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', ss.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', ss.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', ss.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', ss.swap_buf_right)


-- tmux
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>fs', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('n', '<leader>ls', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

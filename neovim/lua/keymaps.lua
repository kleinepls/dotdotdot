vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "K", require("pretty_hover").hover)

vim.keymap.set("n", "<Enter>", "<nop>")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })

-- yanking, deleting
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set("v", "<leader>c", '"_c')

-- tabs
vim.keymap.set("n", "TN", vim.cmd.tabnext)
vim.keymap.set("n", "TP", vim.cmd.tabprevious)
vim.keymap.set("n", "TX", vim.cmd.tabclose)

-- tmux
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>fs", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>ls", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- git
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>")

-- javascript
vim.keymap.set("n", "<leader>cl", "oconsole.log()<Esc>i")

-- vue
vim.keymap.set("n", "<leader>vs", 'i<script setup lang="ts"><CR><CR></script><CR><CR><template><CR></template><Esc>O')
vim.keymap.set(
  "n",
  "<leader>vc",
  'i<template><CR></template><CR><CR><script lang="ts"><CR></script><Esc>Osetup(props, { emit }) {<CR>}<Esc>O'
)

-- go
vim.keymap.set("n", "<leader>er", "oif err != nil {<Enter>}<Esc>O")
vim.keymap.set("n", "<leader>ej", '_yiw~$a `json:"<Esc>pa"`<Esc>V=')

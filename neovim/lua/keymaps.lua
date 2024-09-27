--
-- defaults, builtins
--
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "<Enter>", "<nop>")
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("v", "<space>", "<nop>")

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-j>", "5j")
-- vim.keymap.set("n", "<C-k>", "5k")
-- word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "TN", vim.cmd.tabnext)
vim.keymap.set("n", "TP", vim.cmd.tabprevious)
vim.keymap.set("n", "TX", vim.cmd.tabclose)

-- yanking, deleting
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
-- vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("n", "<leader>rf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rl", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r>0/g<CR>")

--
--
-- plugins
--
--
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit)

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

--
-- language mappings
--

-- go
vim.keymap.set("n", "<leader>er", "oif err != nil {<Enter>}<Esc>Oreturn nil<Esc>")
vim.keymap.set("n", "<leader>ej", '_yiw~$a `json:"<Esc>pa"`<Esc>V=')

-- javascript
vim.keymap.set("n", "<leader>cl", "oconsole.log()<Esc>i")

-- vue
vim.keymap.set("n", "<leader>vs", 'i<script setup lang="ts"><CR><CR></script><CR><CR><template><CR></template><Esc>O')
vim.keymap.set(
  "n",
  "<leader>vc",
  'i<template><CR></template><CR><CR><script lang="ts"><CR></script><Esc>Osetup(props, { emit }) {<CR>}<Esc>O'
)

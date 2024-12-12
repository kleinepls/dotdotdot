--
-- defaults, builtins
--
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("v", "<space>", "<nop>")

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })
vim.keymap.set("n", "<M-j>", "5j")
vim.keymap.set("n", "<M-k>", "5k")
vim.keymap.set("v", "<M-j>", "5j")
vim.keymap.set("v", "<M-k>", "5k")

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
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("n", "<leader>rf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rl", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r>0/g<CR>")

--
--
--

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

--
-- language mappings
--

-- go
vim.keymap.set("n", "<leader>er", "oif err != nil {<Enter>}<Esc>Oreturn nil<Esc>")
vim.keymap.set("n", "<leader>ej", '_yiw~$a `json:"<Esc>pa"`<Esc>V=')

-- vue
vim.keymap.set("n", "<leader>vs", 'i<script setup lang="ts"><CR><CR></script><CR><CR><template><CR></template><Esc>O')
vim.keymap.set(
  "n",
  "<leader>vc",
  'i<template><CR></template><CR><CR><script lang="ts"><CR></script><Esc>Osetup(props, { emit }) {<CR>}<Esc>O'
)

--
--
vim.keymap.set("n", "<leader>co", function()
  local ft = vim.bo.filetype
  local word = vim.fn.expand "<cword>"

  if ft == "javascript" or ft == "typescript" or ft == "vue" or ft == "typesriptreact" then
    if word == "" then
      vim.cmd "normal oconsole.log()"
      vim.cmd "startinsert"
    else
      vim.cmd("normal oconsole.log(" .. word .. ");")
    end
    return
  end
  if ft == "go" then
    if word == "" then
      vim.cmd "normal ofmt.Println()"
      vim.cmd "startinsert"
    else
      vim.cmd("normal ofmt.Println(" .. word .. ")")
    end
    return
  end
end)

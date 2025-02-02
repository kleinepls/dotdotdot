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

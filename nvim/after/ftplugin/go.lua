vim.keymap.set("n", "<leader>ej", '_yiwvUA `json:"<Esc>pbvuA"`<Esc>V=')

vim.keymap.set("i", "<c-e>", function()
  vim.fn.feedkeys("if err != nil {o}Oreturn err")
end)

vim.keymap.set("x", "<c-e>", function()
  vim.fn.feedkeys("Iif err := A; err != nil {o}Oreturn err")
end)

vim.keymap.set("i", "<c-j>", function() -- appends `json:"myProp"`
  vim.cmd.stopinsert()
  vim.defer_fn(function()
    if vim.fn.expand "<cword>" == "}" then
      vim.fn.feedkeys "%_yiwvU$%A `json:\"pbvuA\"`"
    else
      vim.fn.feedkeys "_yiwvUA `json:\"pbvuA\"`"
    end
  end, 0)
end)

vim.keymap.set("i", "<c-n>", function()
  vim.fn.feedkeys "fmt.Printf(\"%+v\\n\", )i"
end)

vim.keymap.set("i", "<c-p>", function()
  vim.fn.feedkeys "fmt.Println()i"
end)

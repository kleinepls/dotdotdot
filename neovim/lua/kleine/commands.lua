vim.keymap.set("n", "<leader>cp", vim.cmd.CopyPath)
vim.keymap.set("n", "<leader>cf", vim.cmd.CopyPathFull)
vim.keymap.set("n", "<leader>cn", vim.cmd.CopyFileName)
vim.keymap.set("n", "<leader>tw", vim.cmd.ToggleWordWrap)

vim.keymap.set("n", "<leader>gg", function()
  vim.ui.input({ prompt = "Search > " }, function(input)
    if input then
      vim.ui.open("https://google.com/search?q=" .. input)
    end
  end)
end)

vim.keymap.set("n", "<leader>gu", function()
  vim.ui.input({ prompt = "URL > " }, function(input)
    if input then
      vim.ui.open("https://" .. input)
    end
  end)
end)

vim.api.nvim_create_user_command("CopyPath", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CopyPathFull", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CopyFileName", function()
  local file = vim.fn.expand "%:t"
  if file ~= "" then
    vim.fn.setreg("+", file)
    vim.notify('Copied "' .. file .. '" to the clipboard!')
  else
    vim.notify "No file opened"
  end
end, {})

vim.api.nvim_create_user_command("ToggleWordWrap", function()
  local wrapped = vim.api.nvim_get_option_value("wrap", {})
  vim.o.wrap = not wrapped

  if wrapped then
    vim.notify "Word wrapping disabled."
    return
  end

  vim.notify "Word wrapping enabled."
end, {})

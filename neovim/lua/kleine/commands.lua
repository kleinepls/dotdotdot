vim.keymap.set("n", "<leader>cp", vim.cmd.CopyPath)
vim.keymap.set("n", "<leader>cf", vim.cmd.CopyPathFull)
vim.keymap.set("n", "<leader>cn", vim.cmd.CopyFileName)
vim.keymap.set("n", "<leader>tw", vim.cmd.ToggleWordWrap)

vim.keymap.set("n", "<leader>tn", function()
  vim.o.number = not vim.api.nvim_get_option_value("number", {})
end)

local function cleanup_path(path)
  return string.gsub(path, "oil://", "")
end

vim.api.nvim_create_user_command("CopyPath", function()
  local path = cleanup_path(vim.fn.expand "%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CopyPathFull", function()
  local path = cleanup_path(vim.fn.expand "%:p")
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

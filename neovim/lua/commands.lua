vim.keymap.set('n', '<leader>cp', vim.cmd.CopyPath)
vim.keymap.set('n', '<leader>cf', vim.cmd.CopyPathFull)
vim.keymap.set('n', '<leader>cn', vim.cmd.CopyFileName)

vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command('CopyPathFull', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command('CopyFileName', function()
  local file = vim.fn.expand '%:t'
  vim.fn.setreg('+', file)
  vim.notify('Copied "' .. file .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command('WordWrapToggle', function()
  local wrapped = vim.api.nvim_get_option_value('wrap', {})
  vim.opt.wrap = not wrapped
end, {})

vim.keymap.set("n", "<leader>cp", vim.cmd.CopyPath)
vim.keymap.set("n", "<leader>cf", vim.cmd.CopyPathFull)
vim.keymap.set("n", "<leader>cn", vim.cmd.CopyFileName)
vim.keymap.set("n", "<leader>tw", vim.cmd.ToggleWordWrap)

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  pattern = "*",
  callback = function() vim.hl.on_yank() end,
})

local mel = require "melange/palettes/dark"
local transparent = false
vim.api.nvim_create_user_command("Transparent", function()
  if transparent then
    transparent = false
    vim.api.nvim_set_hl(0, "Normal", { fg = mel.a.fg, bg = "#1e1b1a" })
    return
  end
  transparent = true
  vim.api.nvim_set_hl(0, "Normal", { bg = nil })
end, {})

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
  vim.notify('copied "' .. path .. '"')
end, {})

vim.api.nvim_create_user_command("CopyPathFull", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify('copied "' .. path .. '"')
end, {})

vim.api.nvim_create_user_command("CopyFileName", function()
  local file = vim.fn.expand "%:t"
  if file ~= "" then
    vim.fn.setreg("+", file)
    vim.notify('copied "' .. file .. '"')
  else
    vim.notify "no file opened"
  end
end, {})

vim.api.nvim_create_user_command("ToggleWordWrap", function()
  local wrapped = vim.api.nvim_get_option_value("wrap", {})
  vim.o.wrap = not wrapped

  if wrapped then
    vim.notify "wrap=false"
    return
  end

  vim.notify "wrap=true"
end, {})

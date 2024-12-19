vim.keymap.set("n", "<leader>x", "<cmd>source %<cr>")

--- storing branch as a local variable so that it wouldn't momentarily disappear from statusline when changing buffers
local branch = ""

--- @param filename string
local function git_branch(filename)
  local head = vim.b.gitsigns_head or ""
  if head == "" then
    return
  end

  local prefix = "  "
  local win_width = vim.api.nvim_win_get_width(0)
  local remaining_width = win_width / 2 - filename:len() / 2

  if prefix:len() + head:len() > remaining_width then
    branch = prefix .. head:sub(0, remaining_width - prefix:len() - 5) .. "..."
  else
    branch = prefix .. head
  end
end

--- @param filename string
--- @return string
local function branch_padding(filename)
  local win_width = vim.api.nvim_win_get_width(0)
  local remaining_width = win_width / 2 - filename:len() / 2 - branch:len()
  return (" "):rep(remaining_width)
end

--- @param filename string
--- @return string
local function statusline(filename)
  git_branch(filename)

  return table.concat {
    branch,
    branch_padding(filename),
    filename,
    " %m",
    "%=",
    " [%l|%L:%c] ",
  }
end

vim.api.nvim_create_autocmd({ "LspProgress", "WinEnter", "BufEnter" }, {
  callback = function()
    vim.wo.statusline = statusline(vim.fn.bufname(vim.fn.bufnr()))
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.wo.statusline = statusline(vim.fn.bufname(vim.fn.bufnr()))
  end,
})

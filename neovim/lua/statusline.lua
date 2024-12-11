vim.keymap.set("n", "<leader>x", "<cmd>source %<cr>")

vim.api.nvim_set_hl(0, "WinbarFileName", { fg = "#ffffff" })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    local dir = vim.fn.expand "%:h"
    local file = vim.fn.expand "%:t"
    vim.opt.winbar = dir .. "/" .. "%#WinbarFileName#" .. file .. "%*" .. " %m"
  end,
})

--- storing branch as a local variable so that it wouldn't momentarily disappear from statusline when changing buffers
local branch = ""

--- @return string
function Statusline()
  local head = vim.b.gitsigns_head
  if head then
    branch = string.format(" %s", head)
  end

  return table.concat {
    " ",
    branch,
    "%=",
    "[%l|%L:%c]",
    " ",
  }
end

vim.o.statusline = "%!v:lua.Statusline()"

vim.api.nvim_create_autocmd({ "LspProgress", "WinEnter", "BufEnter" }, {
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

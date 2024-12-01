vim.api.nvim_set_hl(0, "BoldFileName", { bold = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    local dir = vim.fn.expand "%:h"
    local file = vim.fn.expand "%:t"
    vim.opt.winbar = "%=%m " .. dir .. "/" .. "%#BoldFileName#" .. file .. "%*"
  end,
})

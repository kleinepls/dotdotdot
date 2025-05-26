local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local mel = require "melange/palettes/dark"
vim.api.nvim_set_hl(0, "Normal", { fg = mel.a.fg, bg = "#1e1b1a" })
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#4e433e", italic = false, nocombine = true })
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Whitespace" })

require "kleine.commands"

vim.diagnostic.config {
  signs = false,
  severity_sort = true,
  virtual_text = true,
  virtual_lines = false,
  float = {
    border = "rounded",
    source = true,
  },
}

vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dg", function()
  vim.diagnostic.config {
    virtual_lines = not vim.diagnostic.config().virtual_lines,
  }
end)

vim.opt.statusline = " %f%m   (%l, %L %c)"

vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.rnu = true

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set({ "n", "v" }, "<space>", "<nop>")
-- word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- moving lines/text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })

vim.opt.list = true
vim.opt.listchars = "tab:» →,leadmultispace:† · ‡ · ,trail:▫,precedes:←,extends:◊"
vim.opt.shortmess:append "c"
vim.opt.completeopt = "menu,longest,preview"

vim.opt.signcolumn = "auto"
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.keymap.set({ "n", "v" }, "<M-j>", "5j")
vim.keymap.set({ "n", "v" }, "<M-k>", "5k")
vim.keymap.set("n", "TN", vim.cmd.tabnext)
vim.keymap.set("n", "TP", vim.cmd.tabprevious)
vim.keymap.set("n", "TX", vim.cmd.tabclose)

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<enter>", '"+y') -- matching tmux copy
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.backup = false
vim.opt.isfname:append "@-@"
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- text replacing
vim.keymap.set("n", "<leader>rf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rl", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r>0/g<CR>")

-- quickfix list navigation
-- todo :h setqflist
vim.keymap.set("n", "]e", function()
  if #vim.fn.getqflist() == 0 then
    vim.notify("No items in quickfix list.", vim.log.levels.INFO)
    return
  end
  if not pcall(vim.cmd.cn) then
    vim.cmd.cfirst()
  end
end)
vim.keymap.set("n", "]E", function()
  if #vim.fn.getqflist() == 0 then
    vim.notify("No items in quickfix list.", vim.log.levels.INFO)
    return
  end
  if not pcall(vim.cmd.cN) then
    vim.cmd.clast()
  end
end)

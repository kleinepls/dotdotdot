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

local transparent = false
vim.api.nvim_create_user_command("Transparent", function()
  if transparent then
    transparent = false
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1e1b1a" })
    return
  end
  transparent = true
  vim.api.nvim_set_hl(0, "Normal", { bg = nil })
end, {})

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

vim.o.statusline = " %f%m   (%l, %L %c)"

vim.o.autoindent = true
vim.o.wrap = false
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.nu = true
vim.o.rnu = true

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

vim.o.list = true
vim.o.listchars = "tab:» →,leadmultispace:† · ‡ · ,trail:▫,precedes:←,extends:◊"
vim.opt.shortmess:append "c"
vim.o.completeopt = "menu,longest,preview"

vim.o.signcolumn = "auto"
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true

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

vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.backup = false
vim.opt.isfname:append "@-@"
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.o.undofile = true
vim.o.updatetime = 50

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

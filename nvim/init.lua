vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.termguicolors = true

require "setup"
require "commands"
require "terminal"
require "marks"

vim.cmd.colorscheme "melange"
local mel = require "melange/palettes/dark"
vim.api.nvim_set_hl(0, "Normal", { fg = mel.a.fg, bg = "#1e1b1a" })
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#4e433e", italic = false, nocombine = true })
vim.api.nvim_set_hl(0, "MatchParen", { fg = mel.b.yellow, bg = mel.a.sel, bold = true })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#efcc8a" })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = mel.a.float })
vim.api.nvim_set_hl(0, "SnippetTabstopActive", { bg = nil }) -- to not highlight autocompleted text

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set({ "n", "x" }, "<space>", "<nop>")
-- word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")
-- move lines in visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")
-- keep cursor in place when joining
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = false })

-- do not populate the jumplist with { and } movements
vim.keymap.set("n", "{", "<cmd>keepjumps normal! {<cr>")
vim.keymap.set("n", "}", "<cmd>keepjumps normal! }<cr>")

vim.keymap.set({ "n", "v" }, "<M-j>", "7j")
vim.keymap.set({ "n", "v" }, "<M-k>", "7k")
-- tab navigation
vim.keymap.set("n", "TN", vim.cmd.tabnext)
vim.keymap.set("n", "TP", vim.cmd.tabprevious)
vim.keymap.set("n", "TT", vim.cmd.tabnew)
vim.keymap.set("n", "TX", vim.cmd.tabclose)

vim.keymap.set("n", "<c-e>", "<c-e>j")
vim.keymap.set("n", "<c-y>", "<c-y>k")

-- paste maintaining unnamed register
vim.keymap.set("x", "<leader>p", '"_dP')
-- copy to system
vim.keymap.set("x", "<enter>", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
-- copy file contents
vim.keymap.set("n", "<leader>A", 'ggVG"+y<C-o>')
-- delete to void register
vim.keymap.set("x", "<leader>d", '"_d')

-- text replacing
vim.keymap.set("n", "<leader>rf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- entire file
vim.keymap.set("n", "<leader>rl", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- current line
vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r>0/g<CR>") -- entire file with "0 register

-- go keymaps
vim.keymap.set("n", "<leader>er", "oif err != nil {<Enter>}<Esc>Oreturn err<Esc>")
vim.keymap.set("n", "<leader>ej", '_yiwvUA `json:"<Esc>pbvuA"`<Esc>V=')
vim.keymap.set("i", "<c-n>", function()
  vim.fn.feedkeys("if err != nil {o}Oreturn err")
end)
vim.keymap.set("i", "<c-j>", function() -- appends `json:""`
  vim.cmd.stopinsert()
  vim.fn.feedkeys "%_yiwvU$%A `json:\"pbvuA\"`"
end)

vim.keymap.set("i", "<c-p>", function()
  local ft = vim.bo.ft
  if ft == "go" then
    vim.fn.feedkeys "fmt.Println()i"
  elseif ft == "typescript" or ft == "typescriptreact" or ft == "vue" or ft == "javascript" then
    vim.fn.feedkeys "console.log()i"
  end
end)

-- autocomplete file names
vim.keymap.set("i", "<c-f>", "<c-x><c-f>")
vim.keymap.set("i", "<c-l>", "<right><c-x><c-f>")

-- quickfix list navigation
-- todo :h setqflist
vim.keymap.set("n", "]e", function()
  if not pcall(vim.cmd.cn) then pcall(vim.cmd.cfirst) end
end)
vim.keymap.set("n", "]E", function()
  if not pcall(vim.cmd.cN) then pcall(vim.cmd.clast) end
end)

vim.o.statusline = " %f%m   (%l, %L %c)"

vim.api.nvim_create_autocmd("BufEnter", { -- expands statuscolumn based on buf line count
  callback = function(args)
    local ft, bt = vim.bo.filetype, vim.bo.buftype
    if bt == "nofile" or ft == "DiffviewFiles" then
      vim.o.statuscolumn = ""
      return
    end
    if ft == "help" then
      vim.o.statuscolumn = "%{v:lnum} "
      return
    end

    local l = vim.api.nvim_buf_line_count(args.buf)
    if l > 9999 then
      vim.o.statuscolumn = "%{printf('%6s %2s',v:lnum,v:relnum)}┆"
    elseif l > 999 then
      vim.o.statuscolumn = "%{printf('%5s %2s',v:lnum,v:relnum)}┆"
    else
      vim.o.statuscolumn = "%{printf('%4s %2s',v:lnum,v:relnum)}┆"
    end
  end,
})

vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.list = true
vim.o.listchars = "tab:» →,leadmultispace:† · ‡ · ,trail:▫,precedes:←,extends:◊"
vim.o.fillchars = "diff:╱"
vim.o.relativenumber = true
vim.o.signcolumn = "auto"
vim.o.wrap = false

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.completeopt = "menu,longest,preview"
vim.o.expandtab = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.shortmess:append "c"

vim.o.scrolloff = 8
vim.o.sidescrolloff = 7
vim.o.shiftwidth = 4
vim.o.backup = false
vim.opt.isfname:append "@-@"
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.o.undofile = true
vim.o.updatetime = 200

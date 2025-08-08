local ns = vim.api.nvim_create_namespace("Floaterminal")
vim.api.nvim_set_hl(ns, "NormalFloat", { bg = nil })

local state = {
  buf = -1,
  win = -1,
}

local function create_floating_window(opts)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = opts.buf
  if vim.api.nvim_buf_is_valid(buf) == false then
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    height = height,
    width = width,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_win_set_hl_ns(win, ns)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
  else
    state = create_floating_window { buf = state.buf }
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    vim.cmd.startinsert()
  end
end

vim.keymap.set({ "n", "t" }, "<C-/>", toggle_terminal)
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.api.nvim_create_user_command("Terminal", function()
  vim.cmd.wincmd "v"
  vim.cmd.wincmd "l"
  vim.cmd "terminal"
  vim.cmd "startinsert"
end, {})

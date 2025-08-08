vim.opt.diffopt = {
  "algorithm:myers",
  "closeoff",
  "context:999999",
  "filler",
  "indent-heuristic",
  -- "inline:word",
  "internal",
  -- "iwhite",
  "linematch:200",
}

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr><cmd>wincmd H<cr>")
vim.keymap.set("n", "<leader>gv", vim.cmd.Gvdiffsplit)
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>")
vim.keymap.set("n", "<leader>gd", function()
  vim.fn.feedkeys ":Gvdiffsplit dev"
end)

vim.keymap.set("n", "<leader>gf", function()
  vim.fn.feedkeys ":DiffviewOpen origin/HEAD...HEAD"
end)

return {
  "tpope/vim-fugitive",
  "sindrets/diffview.nvim",

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      attach_to_untracked = true,
      current_line_blame_opts = { delay = 300 },
      on_attach = function()
        vim.keymap.set("v", "<leader>hr",
          function() require "gitsigns".reset_hunk { vim.fn.line ".", vim.fn.line "v" } end)
        vim.keymap.set("n", "<leader>hR", function() require "gitsigns".reset_buffer() end)
        vim.keymap.set("n", "<leader>hb", function() require "gitsigns".blame() end)
        vim.keymap.set("n", "<leader>hd", function() require "gitsigns".diffthis() end)
        vim.keymap.set("n", "<leader>hD", function() require "gitsigns".diffthis("~1") end)
        vim.keymap.set("n", "<leader>hl", function() require "gitsigns".toggle_linehl() end)
        vim.keymap.set("n", "<leader>ht", function() require "gitsigns".toggle_current_line_blame() end)
      end,
    },
  },
}

vim.opt.diffopt = {
  "algorithm:histogram",
  "closeoff",
  "context:999999",
  "filler",
  "indent-heuristic",
  "inline:char",
  "internal",
  -- "iwhite",
  "linematch:40",
}

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr><cmd>wincmd H<cr>")
vim.keymap.set("n", "<leader>gd", function() vim.fn.feedkeys ":Gvdiffsplit dev" end)

vim.keymap.set("n", "<leader>g;", function() vim.fn.feedkeys ":DiffviewOpen origin/HEAD...HEAD" end)
vim.keymap.set("n", "<leader>gp", function() vim.cmd.DiffviewOpen("--imply-local") end)
vim.keymap.set("n", "<leader>gh", function() vim.cmd.DiffviewFileHistory("% -f") end)
vim.keymap.set("n", "<leader>gH", function() vim.cmd.DiffviewFileHistory() end)

return {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  {
    "sindrets/diffview.nvim",
    opts = {
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = true
        end,
      },
    },
  },

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

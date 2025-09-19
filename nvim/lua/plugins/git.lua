vim.opt.diffopt = {
  "algorithm:histogram",
  "closeoff",
  "context:999999",
  "filler",
  "indent-heuristic",
  "inline:word",
  "internal",
  -- "iwhite",
  "linematch:200",
}

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr><cmd>wincmd H<cr>")
vim.keymap.set("n", "<leader>gd", function() vim.fn.feedkeys ":Gvdiffsplit dev" end)

vim.keymap.set("n", "<leader>g;", function() vim.fn.feedkeys ":DiffviewOpen origin/HEAD...HEAD" end)
vim.keymap.set("n", "<leader>gp", function() vim.cmd.DiffviewOpen("--imply-local") end)
vim.keymap.set("n", "<leader>gh", function() vim.cmd.DiffviewFileHistory("% -f") end)
vim.keymap.set("n", "<leader>gH", function() vim.cmd.DiffviewFileHistory() end)
vim.keymap.set("n", "<leader>gP",
  function() vim.cmd.DiffviewFileHistory("--range=origin/HEAD...HEAD --right-only --no-merges") end)

-- keep default diff hl for fugitive and diffview-specific buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "fugitive*.git//", "*DiffviewFilePanel", "*DiffviewFileHistoryPanel" },
  callback = function()
    vim.api.nvim_set_hl(0, "FugitiveDiffDelete", { bg = "#7D2A2F" })
    vim.opt_local.winhl = "DiffDelete:FugitiveDiffDelete"
  end,
})

return {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  {
    "sindrets/diffview.nvim",
    opts = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      hooks = {
        diff_buf_read = function()
          if vim.bo.filetype ~= "markdown" then
            vim.opt_local.wrap = true
          end
        end,
        -- this highlights diffs similarly to github.
        -- https://github.com/sindrets/diffview.nvim/pull/258#issuecomment-1408689220
        diff_buf_win_enter = function(_, _, ctx)
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = "DiffAdd:DiffviewDiffAddAsDelete,DiffDelete:DiffviewDiffDelete"
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = "DiffDelete:DiffviewDiffDelete"
            end
          end
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

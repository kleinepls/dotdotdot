local fugitive = {
  "tpope/vim-fugitive",
  init = function()
    vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr><cmd>wincmd H<cr>")
    vim.keymap.set("n", "<leader>gv", vim.cmd.Gvdiffsplit)
    vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>")
    vim.keymap.set("n", "<leader>gd", function()
      local branch = vim.fn.input "Branch > "
      vim.cmd("Gvdiffsplit " .. branch)
    end)
  end,
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",

  config = function()
    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },

      signcolumn = false,
      numhl = false,

      attach_to_untracked = true,

      current_line_blame = false,
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      current_line_blame_opts = {
        virt_text = true,
        delay = 300,
      },

      on_attach = function()
        local gs = package.loaded.gitsigns

        vim.keymap.set("v", "<leader>hs", function()
          gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "Stage hunk" })

        vim.keymap.set("v", "<leader>hr", function()
          gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "Reset hunk" })

        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

        vim.keymap.set("n", "<leader>hb", function()
          gs.blame_line { full = true }
        end, { desc = "Blame line preview" })

        vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diffview file" })

        vim.keymap.set("n", "<leader>hD", function()
          gs.diffthis { "~" }
        end, { desc = "Diffview against last commit" })

        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
        vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

        vim.keymap.set("v", "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
      end,
    }
  end,
}

return {
  fugitive,
  gitsigns,
}

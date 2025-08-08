return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local fzf = require "fzf-lua"

    fzf.setup {
      "border-fused",
      keymap = {
        builtin = {
          true,
          ["<Esc>"] = "hide",
        },
        fzf = {
          true,
          ["ctrl-q"] = "select-all+accept",
        },
      },
      winopts = {
        fullscreen = true,
        width = 0.85,
        preview = {
          horizontal = "right:55%",
          wrap = true,
        },
      },
      oldfiles = {
        include_current_session = true,
      },
    }

    fzf.register_ui_select()

    vim.keymap.set("n", "<leader>fp", fzf.files)
    vim.keymap.set("n", "<leader>?", fzf.oldfiles)
    vim.keymap.set("n", "<leader>fb", fzf.buffers)
    vim.keymap.set("n", "<leader>fq", fzf.quickfix)
    vim.keymap.set("n", "<leader>fs", fzf.quickfix_stack)
    vim.keymap.set("n", "<leader>flo", fzf.loclist)
    vim.keymap.set("n", "<leader>fls", fzf.loclist_stack)
    vim.keymap.set("n", "<leader>ft", fzf.treesitter)

    vim.keymap.set("n", "<leader>fg", fzf.grep)
    vim.keymap.set("v", "<leader>fv", fzf.grep_visual)
    vim.keymap.set("n", "<leader>fw", fzf.grep_cword)
    vim.keymap.set("n", "<leader>W", fzf.grep_cWORD)
    vim.keymap.set("n", "<leader>G", fzf.live_grep)

    vim.keymap.set("n", "<leader>ff", fzf.git_files)
    vim.keymap.set("n", "<leader>gt", fzf.git_status)
    vim.keymap.set("n", "<leader>gc", fzf.git_commits)
    vim.keymap.set("n", "<leader>gC", fzf.git_bcommits)
    vim.keymap.set("n", "<leader>gb", fzf.git_branches)
    vim.keymap.set("n", "<leader>ga", fzf.git_tags)
    vim.keymap.set("n", "<leader>gx", fzf.git_stash)

    vim.keymap.set("n", "gs", fzf.lsp_references)
    vim.keymap.set("n", "gd", fzf.lsp_definitions)
    vim.keymap.set("n", "gD", fzf.lsp_typedefs)
    vim.keymap.set("n", "gI", fzf.lsp_implementations)
    vim.keymap.set("n", "gc", fzf.lsp_incoming_calls)
    vim.keymap.set("n", "gC", fzf.lsp_outgoing_calls)
    vim.keymap.set("n", "gt", fzf.lsp_code_actions)
    vim.keymap.set("n", "gl", fzf.lsp_finder)
    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", fzf.lsp_workspace_symbols)
    vim.keymap.set("n", "<leader>di", fzf.lsp_document_diagnostics)
    vim.keymap.set("n", "<leader>wi", fzf.lsp_workspace_diagnostics)

    vim.keymap.set("n", "<leader>fe", fzf.resume)
    vim.keymap.set("n", "<leader>fh", fzf.help_tags)
    vim.keymap.set("n", "<leader>fl", fzf.highlights)
    vim.keymap.set("n", "<leader>fc", fzf.commands)
    vim.keymap.set("n", "<leader>fm", fzf.marks)
    vim.keymap.set("n", "<leader>fr", fzf.registers)
    vim.keymap.set("n", "<leader>fk", fzf.keymaps)

    vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf)
    vim.keymap.set("n", "<leader>f/", function()
      local word = vim.fn.expand "<cword>"
      fzf.lgrep_curbuf()
      vim.fn.feedkeys(word)
    end)

    vim.keymap.set("n", "<leader>af", function()
      fzf.files { cwd = vim.fn.expand "%:h" }
    end)
    vim.keymap.set("n", "<leader>ag", function()
      fzf.live_grep_native { cwd = vim.fn.expand "%:h" }
    end)

    vim.keymap.set("n", "<leader>fn", function()
      fzf.files { cwd = "~/dotfiles" }
    end)

    vim.keymap.set("n", "<leader>go", function()
      fzf.files { cwd = "/usr/local/go/src/" }
    end)
  end,
}

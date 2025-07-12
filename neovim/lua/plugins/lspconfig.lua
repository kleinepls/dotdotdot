local mason_packages = vim.fn.stdpath "data" .. "/mason/packages"

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = mason_packages .. "/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
})

vim.lsp.config("vue_ls", {
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
    },
  },
})

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

vim.keymap.set("n", "<leader>dt", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify "Diagnostics hidden."
  else
    vim.diagnostic.enable()
    vim.notify "Diagnostics visible."
  end
end)

vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover {
    border = "rounded",
    max_width = 80,
  }
end)

return {
  { "dmmulroy/tsc.nvim", opts = {} },
  { "j-hui/fidget.nvim", opts = {} },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "folke/lazydev.nvim", opts = {}, ft = "lua" },
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = {
        "gopls",
        "html",
        "lua_ls",
        "rust_analyzer",
        "tailwindcss",
        "ts_ls",
        "vue_ls",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
        javascript = { "eslint_d", "prettierd", "prettier" },
        typescript = { "eslint_d", "prettierd", "prettier" },
        javascriptreact = { "eslint_d", "prettierd", "prettier" },
        typescriptreact = { "eslint_d", "prettierd", "prettier" },
        vue = { "eslint_d", "prettierd", "prettier" },
      },
      format_on_save = function()
        if vim.g.autoformat then
          return {
            timeout_ms = 2000,
            lsp_format = "fallback",
            stop_after_first = true,
            filter = function(client)
              return client.name ~= "ts_ls" and client.name ~= "vue_ls"
            end,
          }
        end
      end,
    },
    init = function()
      vim.keymap.set("n", "<leader>gf", function()
        require("conform").format {
          timeout_ms = 2000,
          lsp_format = "fallback",
          stop_after_first = true,
          filter = function(client)
            return client.name ~= "ts_ls" and client.name ~= "vue_ls"
          end,
        }
      end)

      vim.g.autoformat = true
      vim.keymap.set("n", "<leader>tf", vim.cmd.ToggleFormat)

      vim.api.nvim_create_user_command("ToggleFormat", function()
        vim.g.autoformat = not vim.g.autoformat
        if not vim.g.autoformat then
          vim.notify "Auto formatting disabled."
        else
          vim.notify "Auto formatting enabled."
        end
      end, {})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    init = function()
      require("lint").linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        json = { "jsonlint" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
        callback = function()
          local ok, lint = pcall(require, "lint")
          if ok then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    init = function()
      vim.keymap.set("n", "<leader>tp", "<cmd>Trouble diagnostics toggle focus<cr>")
      vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle focus filter.buf=0<cr>")

      vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus<cr>")

      vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle focus<cr>")

      vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle win.position=bottom<cr>")
    end,
  },
}

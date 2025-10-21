vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data") .. "/lazy/melange-nvim",
        },
      },
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
    virtual_text = not vim.diagnostic.config().virtual_text,
  }
end)

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify "diagnostics=off"
  else
    vim.diagnostic.enable()
    vim.notify "diagnostics=on"
  end
end, {})

vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover {
    border = "rounded",
    max_width = 80,
  }
end)

return {
  { "dmmulroy/tsc.nvim", opts = {} },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
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
        "vtsls",
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
              return client.name ~= "vtsls" and client.name ~= "vue_ls"
            end,
          }
        end
      end,
    },
    init = function()
      vim.keymap.set("n", "<leader>F", function()
        require("conform").format {
          timeout_ms = 2000,
          lsp_format = "fallback",
          stop_after_first = true,
          filter = function(client)
            return client.name ~= "vtsls" and client.name ~= "vue_ls"
          end,
        }
      end)

      vim.g.autoformat = true
      vim.keymap.set("n", "<leader>tf", vim.cmd.ToggleFormat)

      vim.api.nvim_create_user_command("ToggleFormat", function()
        if vim.g.autoformat then
          vim.notify "auto formatting=off"
        else
          vim.notify "auto formatting=on"
        end
        vim.g.autoformat = not vim.g.autoformat
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
}

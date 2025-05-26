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

return {
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

  { "dmmulroy/tsc.nvim", opts = {} },
  { "j-hui/fidget.nvim", opts = {} },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {
      max_width = 80,
    },
    init = function()
      vim.keymap.set("n", "K", require("pretty_hover").hover)
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "eslint_d", "prettierd", "prettier" },
        typescript = { "eslint_d", "prettierd", "prettier" },
        javascriptreact = { "eslint_d", "prettierd", "prettier" },
        typescriptreact = { "eslint_d", "prettierd", "prettier" },
        vue = { "eslint_d", "prettierd", "prettier" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
        stop_after_first = true,
        filter = function(client)
          return client.name ~= "ts_ls" and client.name ~= "vue_ls"
        end,
      },
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

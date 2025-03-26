local lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  init = function()
    local lspconfig = require "lspconfig"
    local telescope = require "telescope.builtin"

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

    vim.keymap.set("n", "gd", telescope.lsp_definitions)
    vim.keymap.set("n", "gr", telescope.lsp_references)
    vim.keymap.set("n", "gD", telescope.lsp_type_definitions)
    vim.keymap.set("n", "gI", telescope.lsp_implementations)
    vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols)

    require("mason-tool-installer").setup {
      ensure_installed = {
        "eslint_d",
        "gopls",
        "html",
        "lua_ls",
        "rust_analyzer",
        "stylua",
        "tailwindcss",
        "ts_ls",
        "volar",
      },
    }

    require("mason-lspconfig").setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {}
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              completion = {
                displayContext = 1,
                callSnippet = "Both",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        }
      end,

      -- reference: https://github.com/williamboman/mason-lspconfig.nvim/issues/371#issuecomment-2188015156
      ["ts_ls"] = function()
        local mason_registry = require "mason-registry"
        local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
          .. "/node_modules/@vue/language-server"

        lspconfig.ts_ls.setup {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
              },
            },
          },
        }
      end,

      ["volar"] = function()
        local mason_registry = require "mason-registry"
        local ts_ls_path = mason_registry.get_package("vue-language-server"):get_install_path()
          .. "/node_modules/typescript/lib/"

        lspconfig.volar.setup {
          init_options = {
            vue = {
              hybridMode = false,
            },
            typescript = {
              tsdk = ts_ls_path,
            },
          },
        }
      end,
    }
  end,
}

return {
  lspconfig,
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

  {
    "stevearc/conform.nvim",
    init = function()
      local conform = require "conform"

      conform.setup {
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
            return client.name ~= "ts_ls" and client.name ~= "volar"
          end,
        },
      }

      vim.keymap.set("n", "<leader>f", function()
        conform.format {
          timeout_ms = 2000,
          lsp_format = "fallback",
          stop_after_first = true,
          filter = function(client)
            return client.name ~= "ts_ls" and client.name ~= "volar"
          end,
        }
      end)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    init = function()
      require("lint").linters_by_ft = {
        css = { "stylint" },
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

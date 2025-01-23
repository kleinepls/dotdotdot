return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
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

return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          vue = { "prettierd", "prettier" },
        },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format {
            bufnr = args.buf,
            lsp_format = "fallback",
            stop_after_first = true,
          }
        end,
      })

      vim.keymap.set("n", "<leader>fr", function()
        require("conform").format {
          bufnr = 0,
          lsp_format = "fallback",
          stop_after_first = true,
        }
      end)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
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
          local lint_status, lint = pcall(require, "lint")
          if lint_status then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}

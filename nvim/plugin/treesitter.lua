vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(e)
    local name, kind = e.data.spec.name, e.data.kind
    if name == "nvim-treesitter" then
      if kind == "install" or kind == "update" then
        if not e.data.active then vim.cmd.packadd "nvim-treesitter" end
        vim.cmd "TSUpdate"
      end
    end
  end,
})

vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
}

require "nvim-treesitter".install {
  "css",
  "go",
  "html",
  "javascript",
  "lua",
  "markdown_inline",
  "rust",
  "tsx", "typescript",
  "vim", "vimdoc", "vue",
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    local installed = vim.list_contains(require "nvim-treesitter".get_installed(), lang)
    local available = vim.list_contains(require "nvim-treesitter".get_available(), lang)

    if installed then
      vim.treesitter.start(args.buf)
    elseif available then
      require "nvim-treesitter".install(lang)
      vim.defer_fn(function()
        if not pcall(vim.treesitter.start, args.buf) then
          vim.notify("failed starting language parser: " .. args.match, vim.log.levels.ERROR)
        end
      end, 3000)
    end
  end,
})

require "nvim-treesitter-textobjects".setup {
  select = {
    lookahead = true,
    -- selection_modes = {},
  },
}

vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set("n", "]z", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "[z", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
end)

vim.keymap.set("n", "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start "@function.outer"
end)
vim.keymap.set("n", "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end "@function.outer"
end)
vim.keymap.set("n", "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start "@function.outer"
end)
vim.keymap.set("n", "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end "@function.outer"
end)

require "treesitter-context".setup {
   max_lines = 3,
}
vim.keymap.set({ "n", "x" }, "]C", function() require("treesitter-context").go_to_context() end)
vim.keymap.set({ "n", "x" }, "]x", function() require("treesitter-context").go_to_context(3) end)

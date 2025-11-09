return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require "multicursor-nvim"
    mc.setup()
    local set = vim.keymap.set
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
    set({ "n", "x" }, "<s-up>", function() mc.lineSkipCursor(-1) end)
    set({ "n", "x" }, "<s-down>", function() mc.lineSkipCursor(1) end)

    local cursor_direction -- storing direction in a variable to have only one skip keymap
    local function match_add(direction)
      cursor_direction = direction
      mc.matchAddCursor(direction)
    end
    set({ "n", "x" }, "<c-v>", function() match_add(1) end)
    set({ "n", "x" }, "<c-b>", function() match_add(-1) end)
    set({ "n", "x" }, "<leader><c-v>", mc.matchAllAddCursors)

    set("v", "I", mc.insertVisual)
    set("v", "A", mc.appendVisual)

    mc.addKeymapLayer(function(layerSet)
      layerSet("n", "<esc>", mc.clearCursors)

      layerSet({ "n", "x" }, "<c-k>", function() mc.matchSkipCursor(cursor_direction) end)

      -- layerSet({ "n", "x" }, "<c-q>", mc.toggleCursor)

      layerSet({ "n", "v" }, "H", mc.firstCursor)
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
    end)

    vim.api.nvim_create_autocmd("BufLeave", {
      callback = function()
        if mc.hasCursors() then
          mc.clearCursors()
        end
      end,
    })
  end,
}

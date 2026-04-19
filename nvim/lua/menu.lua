vim.cmd [[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
  aunmenu PopUp.Select\ All
  aunmenu PopUp.Paste
  aunmenu PopUp.-1-
  "aunmenu PopUp.Show\ All\ Diagnostics
  "aunmenu PopUp.Configure\ Diagnostics

  anoremenu PopUp.Go\ to\ references      <cmd>FzfLua lsp_references<cr>
  anoremenu PopUp.Hover                   <cmd>lua vim.lsp.buf.hover { border = "rounded", max_width = 80 }<cr>
  anoremenu PopUp.-2-                     <Nop>
  anoremenu PopUp.Go\ forward             <c-i>
  anoremenu PopUp.Go\ back                <c-t>
]]

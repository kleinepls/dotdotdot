-- makes jumplist, marks, etc unique per project/directory
local function project_shadafile()
  local root = tostring(vim.fn.finddir(".git", ".;"))
  if root == ".git" or root == "" then
    root = vim.fn.getcwd()
  else
    root = vim.fn.fnamemodify(root, ":h")
  end
  return vim.fs.joinpath(
    vim.fn.stdpath "state",
    "shada",
    vim.fn.fnamemodify(root, ":t") .. ".shada"
  )
end

vim.o.shadafile = project_shadafile()

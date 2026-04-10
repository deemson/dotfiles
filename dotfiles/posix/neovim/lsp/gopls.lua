---@type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod"},
  settings = {
    enable_snippets = false,
  },
}

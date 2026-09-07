---@type vim.lsp.Config
return {
  cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git" },
  workspace_required = false,
  settings = {
    enable_snippets = false,
  },
}

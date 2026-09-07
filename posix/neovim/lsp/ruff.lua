---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  settings = {},
  on_attach = function(client, bufnr)
    _ = bufnr
    -- ruff fights pyright for hover capability
    client.server_capabilities.hoverProvider = false
  end,
}

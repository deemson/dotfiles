---@type vim.lsp.Config
return {
  cmd = { "buf", "lsp", "serve", "--log-format=text" },
  filetypes = { "proto" },
  root_markers = { "buf.yaml", ".git" },
  reuse_client = function(client, config)
    return client.name == config.name
  end,
}

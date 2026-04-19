vim.lsp.enable({
  "lua_language_server",
  -- TOML
  "tombi",
  -- Go
  "gopls",
  -- TypeScript
  "vtsls",
  -- JSON/HTML/CSS
  "vscode_json_language_server",
  -- YAML
  "yaml_language_server",
  -- Python
  "basedpyright",
  "ruff",
  -- GoDot
  "godot",
  -- Protobuf
  "buf",
  -- Zig
  "zls",
})

vim.api.nvim_create_user_command("LspRestart", function()
  local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_client_names = vim.tbl_map(function(lsp_config)
    return lsp_config.name
  end, lsp_clients)

  vim.lsp.stop_client(lsp_clients)
  vim.lsp.enable(lsp_client_names)
end, { desc = "Restart LSP" })

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("edit " .. vim.lsp.get_log_path())
end, { desc = "LSP Logs" })

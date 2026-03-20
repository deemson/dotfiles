vim.lsp.enable({
  "lua_language_server",
  "tombi",
  "gopls",
  "vtsls",
  "vscode_json_language_server",
  "yaml_language_server",
})

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = 0 }))
  vim.cmd("e")
end, { desc = "Restart LSP" })

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("edit " .. vim.lsp.get_log_path())
end, { desc = "LSP Logs" })

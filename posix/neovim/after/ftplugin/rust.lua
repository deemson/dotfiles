-- rustaceanvim's openDocs crashes when rust-analyzer returns null URLs, so send the request directly
local function open_docs()
  local client = vim.lsp.get_clients({ bufnr = 0, name = "rust-analyzer" })[1]
  if not client then
    return
  end
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request("experimental/externalDocs", params, function(_, result)
    local url = result and result.web
    if url == nil or url == vim.NIL then
      vim.notify("No docs for the symbol under cursor", vim.log.levels.INFO)
      return
    end
    vim.ui.open(url)
  end, 0)
end

vim.keymap.set("n", "<leader>l?", open_docs, { buffer = 0, desc = "Rust: open docs.rs" })
vim.keymap.set("n", "<leader>lm", function()
  vim.cmd.RustLsp("expandMacro")
end, { buffer = 0, desc = "Rust: expand macro" })

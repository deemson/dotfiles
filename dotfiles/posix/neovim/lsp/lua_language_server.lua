---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".emmyrc.json",
    ".luarc.json",
    ".luarc.jsonc",
    ".stylua.toml",
    "stylua.toml",
    ".git",
  },
  settings = {
    Lua = {
      telemetry = { enable = false },
    },
  },
  on_attach = function(client, bufnr)
    local buf_file_path = vim.api.nvim_buf_get_name(bufnr)
    local is_inside_vim_runtime = vim.startswith(buf_file_path, vim.env.VIMRUNTIME)
    local is_inside_config = vim.startswith(buf_file_path, vim.fn.stdpath("config"))
    local is_inside_data = vim.startswith(buf_file_path, vim.fn.stdpath("data"))
    local is_nvim_dir = is_inside_vim_runtime or is_inside_config or is_inside_data
    local is_dot_nvim_lua = vim.endswith(buf_file_path, ".nvim.lua")
    if is_nvim_dir or is_dot_nvim_lua then
      client.settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.stdpath("config"),
              vim.fn.stdpath("data") .. "/lazy",
            },
          },
          diagnostics = {
            globals = { "vim" },
          },
        },
      }
    end
  end,
}

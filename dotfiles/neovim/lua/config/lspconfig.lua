local lspconfig = require('lspconfig')
local blinkcmp = require('blink.cmp')

local configs = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        telemetry = { enable = false }
      }
    }
  },
  pylsp = {},
  ols = {},
  clangd = {},
  terraformls = {}
}

for name, config in pairs(configs) do
  config.capabilities = blinkcmp.get_lsp_capabilities(config.capabilities)
  lspconfig[name].setup(config)
end

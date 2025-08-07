local lspconfig = require("lspconfig")
local blinkcmp = require("blink.cmp")

local configs = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  },
  nixd = {},
  html = {},
  cssls = {},
  jsonls = {},
  pyright = {},
  ols = {},
  clangd = {
    filetypes = { "c", "cpp" },
  },
  dockerls = {},
  terraformls = {},
  gopls = {
    settings = {
      gopls = {
        -- completes the stuff that hasn't been imported yet
        completeUnimported = true,
        -- put argument placeholders when importing functions
        -- usePlaceholders = true,
      },
    },
  },
  zls = {},
  buf_ls = {},
  ts_ls = {},
  astro = {},
  tailwindcss = {},
  glsl_analyzer = {},
}

for name, config in pairs(configs) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- enable file watching explicitly as it's disabled on Linux by default
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
  config.capabilities = blinkcmp.get_lsp_capabilities(capabilities)
  lspconfig[name].setup(config)
end

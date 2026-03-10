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
        analyses = {
          unsafeptr = false,
        },
      },
    },
  },
  zls = {},
  buf_ls = {},
  ts_ls = {},
  astro = {},
  tailwindcss = {},
  glsl_analyzer = {},
  ansiblels = {},
  slangd = {},
  gdscript = {
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    filetypes = { "gd", "gdscript", "gdscript3" },
    root_markers = { "project.godot", ".git" },
  },
}

for name, config in pairs(configs) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- enable file watching explicitly as it's disabled on Linux by default
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
  config.capabilities = blinkcmp.get_lsp_capabilities(capabilities)
  vim.lsp.enable(name)
  vim.lsp.config(name, config)
end

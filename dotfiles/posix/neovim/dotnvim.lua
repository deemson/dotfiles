vim.lsp.config("lua_language_server", {
  settings = {
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
  },
})

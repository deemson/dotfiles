-- lazydev improves loading times for Lua LSP
return {
  "folke/lazydev.nvim",
  lazy = false,
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      "lazy.nvim",
      vim.fn.stdpath("data") .. "/lazy/neotest/lua",
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  config = function ()
    require("lazydev").setup({})
  end
}

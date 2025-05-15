-- mason-lspconfig is mason integration with lspconfig
return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup()
  end,
}

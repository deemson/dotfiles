-- mason is a package manager for language-specific LSPs, formatters and DAPs
return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({})
  end
}

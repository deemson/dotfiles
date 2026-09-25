-- otter.nvim proxies LSP requests to hidden buffers built from Tree-sitter injections.
return {
  "jmbuhr/otter.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  config = function(_, opts)
    require("otter").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "texmustache",
      callback = function()
        require("otter").activate({ "latex" })
      end,
      desc = "Enable LaTeX LSP inside Mustache templates",
    })
  end,
}

-- aerial provides a window with code outline (functions, classes etc)
return {
  "stevearc/aerial.nvim",
  opts = {
    disable_max_lines = 30000,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}

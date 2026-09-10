-- nvim-treesitter-textobjects is a plugin on top of treesitter
-- to allow operations on chunks of code parsed by treesitter (classes, functions, etc)
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}

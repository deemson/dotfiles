require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc" },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},
})

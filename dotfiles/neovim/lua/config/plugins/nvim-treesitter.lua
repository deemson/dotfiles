require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc" },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
    },
  },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99
vim.wo.foldenable = false

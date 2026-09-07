vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

require("utils.textobjects").setup_buf({
  select = { "block" },
})

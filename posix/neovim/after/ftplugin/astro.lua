vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

require("utils.textobjects").setup_buf({
  select = { "function", "block", "call", "parameter", "assignment", "comment", "conditional", "loop" },
  move = { "function" },
})

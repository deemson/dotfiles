vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

require("utils.textobjects").setup_buf({
  select = { "function", "block", "call", "parameter", "assignment", "comment", "conditional", "loop", "statement" },
  move = { "function" },
})

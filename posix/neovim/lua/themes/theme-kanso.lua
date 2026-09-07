-- color theme
return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("kanso-zen")
    -- vim.cmd.colorscheme("kanso-ink")
    -- vim.cmd.colorscheme("kanso-mist")
    -- vim.cmd.colorscheme("kanso-pearl")
  end,
}

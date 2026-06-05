-- color theme
return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- vim.cmd.colorscheme("catppuccin-latte")
    -- vim.cmd.colorscheme("catppuccin-frappe")
    -- vim.cmd.colorscheme("catppuccin-macchiato")
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}

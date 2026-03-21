-- color theme
return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.cmd.colorscheme("gruvbox-material")
  end,
}

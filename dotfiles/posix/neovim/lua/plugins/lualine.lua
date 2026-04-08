-- lualine is a pretty status line at the bottom

local function winbar_macro_rec()
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    return " " .. reg
  end
  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "gruvbox-material",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
        always_show_tabline = true,
        refresh = { statusline = 100, tabline = 100, winbar = 100 },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { winbar_macro_rec },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}

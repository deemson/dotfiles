-- lualine is a pretty status line at the bottom
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function winbar_macro_rec()
      local reg = vim.fn.reg_recording()
      if reg ~= "" then
        return " " .. reg
      end
      return ""
    end

    local disabled_filetypes = {
      statusline = { "terminal", "trouble", "gitsigns-blame", "neo-tree", "aerial" },
      winbar = { "terminal", "trouble", "gitsigns-blame", "neo-tree", "aerial" },
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "gruvbox-material",
        -- component_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- section_separators = { left = '', right = '' },
        section_separators = { left = "", right = "" },
        disabled_filetypes = disabled_filetypes,
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
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
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {},
      inactive_winbar = {},
      tabline = {},
    })
  end,
}

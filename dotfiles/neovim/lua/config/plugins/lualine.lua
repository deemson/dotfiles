local winbar_path = require("lualine.components.filename"):extend()

function winbar_path:init(options)
  options.path = 1
  winbar_path.super.init(self, options)
end

function winbar_path:update_status()
  if vim.bo.filetype == "oil" then
    local ok, oil = pcall(require, "oil")
    if ok and oil.get_current_dir then
      local result = vim.fn.fnamemodify(oil.get_current_dir(), ":~:.")
      if result == "" then
        return "."
      end
      return result
    end
    return "?"
  end
  return winbar_path.super.update_status(self)
end

local function winbar_macro_rec()
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    return " " .. reg
  end
  return ""
end

local neotest_filetypes = {
  "neotest-summary",
  "neotest-output-panel",
}
local dapui_filetypes = {
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dap-repl",
  "dapui_console",
}
local disabled_filetypes = {
  statusline = { "terminal", "oil", "neotest-summary", "trouble", "gitsigns-blame" },
  winbar = { "terminal", "neotest-summary", "trouble", "gitsigns-blame" },
}
for _, neotest_filetype in ipairs(neotest_filetypes) do
  table.insert(disabled_filetypes.statusline, neotest_filetype)
  table.insert(disabled_filetypes.winbar, neotest_filetype)
end
for _, dapui_filetype in ipairs(dapui_filetypes) do
  table.insert(disabled_filetypes.statusline, dapui_filetype)
  table.insert(disabled_filetypes.winbar, dapui_filetype)
end

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
    lualine_c = {},
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
  winbar = {
    lualine_a = { { winbar_path, separator = { right = "" } } },
    lualine_b = { winbar_macro_rec },
    lualine_c = {},
    lualine_x = { { "filetype", icon_only = true } },
    lualine_y = { { "progress", separator = { left = "" } } },
    lualine_z = { { "location", separator = { left = "" } } },
  },
  inactive_winbar = {
    lualine_a = { winbar_path },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { { "filetype", icon_only = true } },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  tabline = {},
})

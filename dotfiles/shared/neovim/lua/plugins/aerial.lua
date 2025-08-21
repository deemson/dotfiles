-- aerial provides a window with code outline (functions, classes etc)
return {
  "stevearc/aerial.nvim",
  opts = {
    disable_max_lines = 30000,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    local keys = {
      { "a", "Toggle!" },
      { "[", "Prev" },
      { "]", "Next" },
      { "n", "NavToggle" },
    }
    for _, k in ipairs(keys) do
      vim.keymap.set({ "n" }, "<leader>a" .. k[1], "<Cmd>Aerial" .. k[2] .. "<CR>", { noremap = true, silent = false })
    end
  end,
}

-- barbar provides nice UI to manage buffers as tabs
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
    local keys = {
      { "A-,", "BufferPrevious" },
      { "A-.", "BufferNext" },
      { "A-C-,", "BufferMovePrevious" },
      { "A-C-.", "BufferMoveNext" },
      { "A-1", "BufferGoto 1" },
      { "A-2", "BufferGoto 2" },
      { "A-3", "BufferGoto 3" },
      { "A-4", "BufferGoto 4" },
      { "A-5", "BufferGoto 5" },
      { "A-6", "BufferGoto 6" },
      { "A-7", "BufferGoto 7" },
      { "A-8", "BufferGoto 8" },
      { "A-9", "BufferGoto 9" },
      { "A-0", "BufferLast" },
    }
    for _, k in ipairs(keys) do
      vim.keymap.set({ "n", "t" }, "<" .. k[1] .. ">", "<Cmd>" .. k[2] .. "<CR>", { noremap = true, silent = false })
    end

    local filetypes_not_to_close = { "neo-tree", "toggleterm" }

    vim.keymap.set({ "n", "t" }, "<A-c>", function()
      for _, ft in ipairs(filetypes_not_to_close) do
        if vim.bo.filetype == ft then
          vim.notify("cannot close buffer for '" .. ft .. "'", vim.log.levels.ERROR)
          return
        end
      end
      vim.cmd("BufferClose")
    end, { noremap = true, silent = false })
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}

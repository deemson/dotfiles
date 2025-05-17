-- neo-tree is a tree-like file explorer
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { "__pycache__" },
          never_show_by_pattern = { "*.egg-info" },
        },
      },
    })
    vim.keymap.set("n", "<F2>", "<Cmd>Neotree toggle<CR>")
    vim.keymap.set("n", "<F3>", "<Cmd>Neotree reveal=true<CR>")
  end,
}

-- which-key provides a pop-up with contextual help when using multikey bindings such as Ctrl-W
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>t", group = "Telescope" },
      { "<leader>tg", group = "Git" },
      { "<leader>tl", group = "LSP" },
      { "<leader>x", group = "Trouble" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>a", group = "Aerial" },
    })
  end,
}

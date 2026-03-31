-- which-key provides a pop-up with contextual help when using multikey bindings such as Ctrl-W
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>x", group = "Trouble" },
      { "<leader>a", group = "Aerial" },
      { "<leader>d", group = "DAP" },
    })
  end,
}

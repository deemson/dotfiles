return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- diffs
    "sindrets/diffview.nvim",
    -- "esmuellert/codediff.nvim",
  },
  cmd = "Neogit",
  config = function()
    local neogit = require("neogit")
    neogit.setup({
      graph_style = "unicode",
    })
  end,
}

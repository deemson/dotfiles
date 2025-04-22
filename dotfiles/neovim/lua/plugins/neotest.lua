-- neotest is a neovim test runner
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters dependencies
    "marilari88/neotest-vitest",
    "fredrikaverpil/neotest-golang",
  },
}

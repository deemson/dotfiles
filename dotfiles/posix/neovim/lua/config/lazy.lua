---@type LazyConfig
local config = {
  spec = { { import = "plugins" } },
  checker = { enabled = false, notify = false },
  rocks = {
    enabled = false,
  },
}
require("lazy").setup(config)

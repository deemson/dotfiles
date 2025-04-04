---@module 'oil'
---@type oil.Config
local config = {
  watch_for_changes = true
}
require('oil').setup(config)

vim.keymap.set('n', '<leader>o', '<Cmd>Oil<CR>', { desc = 'Oil' })

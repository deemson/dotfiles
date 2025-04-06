local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  hidden = true,
  direction = 'float',
  float_opts = { border = 'double' }
})

local function toggle() lazygit:toggle() end

vim.keymap.set('n', '<A-g>', toggle, { desc = 'Lazygit' })
vim.keymap.set('t', '<A-g>', toggle, { desc = 'Lazygit' })

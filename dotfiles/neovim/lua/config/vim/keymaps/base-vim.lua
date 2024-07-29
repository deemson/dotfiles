-- set space as <leader> key
vim.g.mapleader = ' '

-- yank to system buffer
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

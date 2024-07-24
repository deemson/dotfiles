-- turn on line numbers
vim.wo.number = true
-- display relative line numbers for easier navigation
vim.wo.relativenumber = true
-- set space as <leader> key
vim.g.mapleader = ' '

-- show tabs/spaces/etc
vim.opt.list = true
-- set display symbols for them
vim.opt.listchars = { tab = '→ ', space = '·', trail = '·', extends = '▶', precedes = '◀' }

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

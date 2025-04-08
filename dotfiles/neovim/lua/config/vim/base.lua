-- turn on line numbers
vim.wo.number = true
-- display relative line numbers for easier navigation
vim.wo.relativenumber = true

-- show tabs/spaces/etc
vim.opt.list = true
-- set display symbols for them
vim.opt.listchars = { tab = '→ ', space = '·', trail = '·', extends = '▶', precedes = '◀' }

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- disable word wrap
vim.opt.wrap = false

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- split on the right (vim does this on the left by default)
vim.opt.splitright = true

vim.diagnostic.config({
  virtual_text = true
})

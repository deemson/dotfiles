vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    -- vim.keymap.set('n', '<leader>f', ':Format<CR>', { buffer = true, silent = true, noremap = true })
  end
})

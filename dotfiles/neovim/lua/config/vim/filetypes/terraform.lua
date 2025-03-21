vim.api.nvim_create_autocmd('FileType', {
  pattern = 'terraform',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

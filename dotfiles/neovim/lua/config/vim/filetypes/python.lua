vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = 0 })
  end
})

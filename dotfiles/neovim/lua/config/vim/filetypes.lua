local filetypes = {
  {
    pattern = 'lua',
    callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      -- vim.keymap.set('n', '<leader>f', ':Format<CR>', { buffer = true, silent = true, noremap = true })
    end
  },
  {
    pattern = 'zsh',
    callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
    end
  },
  {
    pattern = 'python',
    callback = function()
      -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = 0 })
    end
  },
  {
    pattern = 'terraform',
    callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
    end
  }
}

for _, c in ipairs(filetypes) do
  vim.api.nvim_create_autocmd('FileType', c)
end

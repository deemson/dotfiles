require('formatter').setup({
  filetype = {
    lua = {
      function()
        return {
          exe = vim.fn.stdpath('data') .. '/mason/bin/lua-format',
          args = {
            '--column-limit=120',
            '--indent-width=2',
            '--spaces-inside-table-braces',
            '--double-quote-to-single-quote',
            '--chop-down-table'
          },
          stdin = true
        }
      end
    },
    python = {
      function()
        return { exe = vim.fn.stdpath('data') .. '/mason/bin/black', args = { '--line-length=79' }, sdtin = true }
      end
    },
    terraform = { function() return { exe = vim.fn.stdpath('data') .. '/mason/bin/terraform-ls', stdin = true } end },
    ['*'] = { function() vim.lsp.buf.format() end }
  }
})

vim.keymap.set('n', '<A-f>', ':Format<CR>', { silent = true, noremap = true })
vim.keymap.set('v', '<A-f>', ':Format<CR>', { silent = true, noremap = true })

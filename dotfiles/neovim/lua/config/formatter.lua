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
    }
  }
})

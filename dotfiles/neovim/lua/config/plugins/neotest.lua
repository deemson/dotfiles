local neotest = require('neotest')

neotest.setup({
  icons = {
    passed = "o",
    failed = "x",
    running = ">",
    skipped = "-",
    unknown = "?"
  },
  adapters = { require('neotest-golang') }
})

vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end, { desc = 'nearest' })

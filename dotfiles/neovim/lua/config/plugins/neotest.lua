local neotest = require('neotest')

neotest.setup({ adapters = { require('neotest-golang') } })

vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end, { desc = 'nearest' })

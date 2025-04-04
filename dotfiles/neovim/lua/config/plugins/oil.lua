require('oil').setup({
  watch_for_changes = true,
  win_options = {
    signcolumn = "yes:2",
    winbar = "hello"
  }
})

vim.keymap.set('n', '<leader>o', '<Cmd>Oil<CR>', { desc = 'Oil' })

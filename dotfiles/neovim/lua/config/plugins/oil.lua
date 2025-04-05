require('oil').setup({
  watch_for_changes = true,
  win_options = {
    signcolumn = 'yes:2',
    -- display current directory at the top and replace part equal to $HOME with ~
    -- winbar = '%#@attribute.builtin#%{substitute(v:lua.require("oil").get_current_dir(), "^" . $HOME, "~", "")}'
  }
})

vim.keymap.set('n', '<leader>o', '<Cmd>Oil<CR>', { desc = 'Oil' })

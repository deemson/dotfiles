require("oil").setup({
  default_file_explorer = true,
  watch_for_changes = true,
  win_options = {
    signcolumn = "yes:2",
  },
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>o", "<Cmd>Oil<CR>", { desc = "Oil" })

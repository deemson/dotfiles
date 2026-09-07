-- gitsigns provides information about changed lines in a file
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function ()
        vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>")
        vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>")
        vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>")
      end
    })
  end,
}

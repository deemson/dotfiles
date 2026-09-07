-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = 0 })

require("utils.textobjects").setup_buf({
  select = { "function", "class", "block", "call", "parameter", "assignment", "comment", "conditional", "loop", "statement" },
  move = { "function", "class" },
})

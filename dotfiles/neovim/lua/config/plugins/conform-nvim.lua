local conform = require("conform")

local prettier = { "prettier", stop_after_first = true }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = prettier,
    typescript = prettier,
    javascriptreact = prettier,
    typescriptreact = prettier,
    go = { "gofmt" },
    python = { "ruff_format" },
  },
  formatters = {
    stylua = {
      prepend_args = {
        "--indent-type=Spaces",
        "--indent-width=2",
      },
    },
  },
})

vim.keymap.set("n", "<A-f>", conform.format)
vim.keymap.set("v", "<A-f>", conform.format)

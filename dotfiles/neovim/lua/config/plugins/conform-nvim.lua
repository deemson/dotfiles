local conform = require("conform")

local js_formatter = { "biome", stop_after_first = true }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = js_formatter,
    typescript = js_formatter,
    javascriptreact = js_formatter,
    typescriptreact = js_formatter,
    json = js_formatter,
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

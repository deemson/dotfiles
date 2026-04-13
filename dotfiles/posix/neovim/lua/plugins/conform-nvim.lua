-- conform-nvim is a code formatting plugin
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    local js_formatter = { "biome" }

    conform.setup({
      format_on_save = nil,
      format_after_save = nil,
      formatters_by_ft = {
        lua = { "stylua" },
        toml = { "tombi" },
        go = { "gofmt" },
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        json = js_formatter,
        jsonc = js_formatter,
        yaml = { "yamlfmt" },
        python = { "ruff_format" },
        zig = { "zigfmt" },
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
  end,
}

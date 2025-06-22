-- conform-nvim is a code formatting plugin
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    local js_formatter = { "biome", "prettierd" }

    conform.setup({
      format_on_save = nil,
      format_after_save = nil,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        json = js_formatter,
        jsonc = js_formatter,
        css = js_formatter,
        less = js_formatter,
        yaml = { "prettierd" },
        go = { "gofmt" },
        python = { "ruff_format" },
      },
      formatters = {
        biome = {
          inherit = true,
          cwd = util.root_file({ "biome.json" }),
          require_cwd = true,
        },
        -- prettierd = {
        --   inherit = true,
        --   cwd = util.root_file({ "prettier.config.mjs" }),
        --   require_cwd = true
        -- },
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

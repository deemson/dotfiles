-- nvim-treesitter provides better syntax highlight
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "bash", "regex", "c", "lua", "vim", "vimdoc" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["a."] = "@call.outer",
            ["i."] = "@call.inner",
            ["a,"] = "@parameter.outer",
            ["i,"] = "@parameter.inner",
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",
            ["=["] = "@assignment.lhs",
            ["=]"] = "@assignment.rhs",
            ["s"] = "@statement.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = "@class.outer",
            ["]f"] = "@function.outer",
          },
          goto_previous_start = {
            ["[c"] = "@class.outer",
            ["[f"] = "@function.outer",
          },
        },
      },
    })

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldlevel = 99
    vim.wo.foldenable = false
  end,
}

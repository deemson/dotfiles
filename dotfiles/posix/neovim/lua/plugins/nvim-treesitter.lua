-- nvim-treesitter provides better syntax highlight
return {
  "nvim-treesitter/nvim-treesitter",
  -- legacy branch, main is the latest but required neovim 0.12
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "bash", "regex", "c", "lua", "vim", "vimdoc" },
      -- synchronous installation of parsers
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        ---@diagnostic disable-next-line: unused-local
        disable = function(lang, buf)
          local max_filesize = 500 * 1024 -- 500 KB
          ---@diagnostic disable-next-line: undefined-field
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
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

-- nvim-treesitter manages treesitter parsers
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  init = function()
    local function register_custom_parsers()
      local parsers = require("nvim-treesitter.parsers")

      -- Override the `just` parser with casey/tree-sitter-just#204 (grammar aligned
      -- with just's GRAMMAR.md: `mod`/`foo::bar` targets, attributes, `?` sigil,
      -- x"" and f"" string prefixes). Drop this once the PR is merged upstream.
      parsers.just = {
        install_info = {
          url = "https://github.com/tkatter/tree-sitter-just",
          revision = "912ac5a7b763af3ac488dbfaafb05fde7e926ece",
          queries = "queries/just",
        },
      }

      -- This grammar recognizes Mustache tags and sections while representing
      -- everything else as generic text. For *.tex.mustache files, our custom
      -- injection query reparses those text ranges with the LaTeX parser.
      parsers.htmlmustache = {
        install_info = {
          url = "https://github.com/PrairieLearn/tree-sitter-htmlmustache",
          revision = "61b638393ae918b07e02e4a87fba78d61869616f",
          queries = "queries",
        },
      }
    end

    register_custom_parsers()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = register_custom_parsers,
    })

    vim.treesitter.language.register("htmlmustache", "texmustache")
  end,
  config = function()
    local treesitter = require("nvim-treesitter")
    local treesitter_config = require("nvim-treesitter.config")

    local function start(buf, lang)
      vim.treesitter.start(buf, lang)
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        vim.o.foldlevel = 99
        vim.o.foldenable = false

        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft) or ft

        -- already installed? just start highlighting
        if vim.list_contains(treesitter_config.get_installed(), lang) then
          start(args.buf, lang)
          return
        end

        -- not installed, but available -> install then start
        if vim.list_contains(treesitter.get_available(), lang) then
          vim.notify("installing treesitter parser '" .. lang .. "' for " .. ft, vim.log.levels.INFO)
          treesitter.install(lang):await(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              start(args.buf, lang)
            end
          end)
        end
      end,
    })
  end,
}

-- nvim-treesitter manages treesitter parsers
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
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

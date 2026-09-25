---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  -- Otter uses `latex` for its hidden buffer instead of Neovim's usual `tex`.
  filetypes = { "tex", "plaintex", "bib", "latex" },
  root_markers = {
    ".git",
    ".latexmkrc",
    "latexmkrc",
    ".texlabroot",
    "texlabroot",
    "Tectonic.toml",
  },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = false,
        forwardSearchAfter = false,
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false,
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      bibtexFormatter = "texlab",
      formatterLineLength = 80,
    },
  },
}

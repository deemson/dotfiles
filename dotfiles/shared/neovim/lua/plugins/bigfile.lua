-- bigfile improves handling of large files
return {
  "LunarVim/bigfile.nvim",
  config = function()
    local notify_file_is_big = {
      name = "notify_file_is_big",
      opts = {
        defer = false,
      },
      disable = function(bufnr)
        local full_path = vim.api.nvim_buf_get_name(bufnr)
        local relative_path = vim.fn.fnamemodify(full_path, ":.")
        vim.notify("file considered big: '" .. relative_path .. "'", vim.log.levels.WARN)
      end,
    }

    require("bigfile").setup({
      filesize = 0.5, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = { -- features to disable
        ---@diagnostic disable-next-line: assign-type-mismatch
        notify_file_is_big,
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "vimopts",
        "filetype",
      },
    })
  end,
}

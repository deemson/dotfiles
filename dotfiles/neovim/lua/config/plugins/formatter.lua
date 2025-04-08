local function prettierd()
  return { exe = "prettierd", args = { vim.api.nvim_buf_get_name(0) }, stdin = true }
end

require("formatter").setup({
  filetype = {
    lua = {
      function()
        return {
          exe = vim.fn.stdpath("data") .. "/mason/bin/stylua",
          args = {
            "--indent-type=Spaces",
            "--indent-width=2",
            "-",
          },
          stdin = true,
        }
      end,
    },
    python = {
      function()
        return { exe = vim.fn.stdpath("data") .. "/mason/bin/black", args = { "--line-length=79" }, sdtin = true }
      end,
    },
    javascript = { prettierd },
    typescript = { prettierd },
    astro = { prettierd },
    terraform = {
      function()
        return { exe = vim.fn.stdpath("data") .. "/mason/bin/terraform-ls", stdin = true }
      end,
    },
    ["*"] = {
      function()
        vim.lsp.buf.format()
      end,
    },
  },
})

vim.keymap.set("n", "<A-f>", ":Format<CR>", { silent = true, noremap = true })
vim.keymap.set("v", "<A-f>", ":Format<CR>", { silent = true, noremap = true })

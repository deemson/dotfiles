-- set space as <leader> key
vim.g.mapleader = " "

-- borrowed from https://github.com/ThePrimeagen/init.lua
-- delete and paste without changing the yank register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Delete & paste" })
-- yank into system buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into system buffer" })
-- same as above but for the entire line and only in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into system buffer" })

local window_management = {
  ["<A-C>"] = "<C-W>c",
  ["<A-j>"] = "<C-W>j",
  ["<A-k>"] = "<C-W>k",
  ["<A-h>"] = "<C-W>h",
  ["<A-l>"] = "<C-W>l",
  ["<A-J>"] = "<C-W>10<",
  ["<A-K>"] = "<C-W>10>",
  ["<A-H>"] = "<C-W>5-",
  ["<A-L>"] = "<C-W>5+",
}

for k, v in pairs(window_management) do
  vim.keymap.set("n", k, v)
end

vim.keymap.set("n", "<A-m>", "<cmd>messages<CR>", { desc = "Messages" })
vim.keymap.set("n", "<A-i>", vim.lsp.buf.hover, { desc = "LSP Hover" })

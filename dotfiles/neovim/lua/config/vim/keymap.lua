-- set space as <leader> key
vim.g.mapleader = " "

-- borrowed from https://github.com/ThePrimeagen/init.lua
-- delete and paste without changing the yank register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Delete & paste" })
-- yank into system buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into system buffer" })
-- same as above but for the entire line and only in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into system buffer" })

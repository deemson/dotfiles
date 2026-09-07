-- set space as <leader> key
vim.g.mapleader = " "

-- borrowed from https://github.com/ThePrimeagen/init.lua
-- delete and paste without changing the yank register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Delete & paste" })
-- yank into system buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into system buffer" })
-- same as above but for the entire line and only in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into system buffer" })

local function yank_selection_reference()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Cannot reference an unnamed buffer", vim.log.levels.WARN)
    return
  end

  local first_line = vim.fn.line("v")
  local last_line = vim.fn.line(".")
  if first_line > last_line then
    first_line, last_line = last_line, first_line
  end

  local relative_path = vim.fn.fnamemodify(path, ":.")
  local line_range = first_line == last_line and tostring(first_line)
    or string.format("%d-%d", first_line, last_line)
  local reference = string.format("%s:%s", relative_path, line_range)

  vim.fn.setreg("+", reference)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  vim.notify("Yanked reference: " .. reference)
end

vim.keymap.set("x", "<leader>yr", yank_selection_reference, { desc = "Yank selection reference" })

vim.keymap.set("i", "<C-,>", "<C-d>", { noremap = true })
vim.keymap.set("i", "<C-.>", "<C-t>", { noremap = true })

local window_tab_management = {
  -- close window
  ["<A-C>"] = "<C-W>c",
  -- moving between windows
  ["<A-j>"] = "<C-W>j",
  ["<A-k>"] = "<C-W>k",
  ["<A-h>"] = "<C-W>h",
  ["<A-l>"] = "<C-W>l",
  -- changing window size
  ["<A-C-j>"] = "<C-W>10<",
  ["<A-C-k>"] = "<C-W>10>",
  ["<A-C-h>"] = "<C-W>5-",
  ["<A-C-l>"] = "<C-W>5+",

  -- close tab
  ["<A-X>"] = "<cmd>tabclose<CR>",
  -- moving between tabs
  ["<A-,>"] = "<cmd>tabprevious<CR>",
  ["<A-.>"] = "<cmd>tabnext<CR>",
}

for k, v in pairs(window_tab_management) do
  vim.keymap.set("n", k, v)
end

vim.keymap.set("n", "<A-m>", "<cmd>messages<CR>", { desc = "Messages" })
vim.keymap.set("n", "<A-/>", "<cmd>nohl<CR>", { desc = "No Highlight" })

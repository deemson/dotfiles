local oil = require("oil")

local function get_current_dir()
  if vim.bo.filetype == "oil" then
    return oil.get_current_dir()
  end
  local buf_path = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(buf_path, ":p:h")
end

local function open(dir)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  local shell = os.getenv("SHELL") or "/bin/sh"

  vim.bo[buf].filetype = "terminal"

  vim.fn.termopen(shell, {
    cwd = dir,
    on_exit = function()
      vim.schedule(function()
        -- Close the buffer and its window after terminal exits
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end,
  })

  vim.cmd("startinsert")
end

local function open_cur_dir()
  open(get_current_dir())
end

local function open_work_dir()
  open(nil)
end

vim.keymap.set("n", "<A-t>", open_cur_dir, { desc = "Terminal (Current Dir)" })
vim.keymap.set("n", "<A-T>", open_work_dir, { desc = "Terminal (Work Dir)" })
vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

local window_management = {
  ["<A-j>"] = "<C-W>j",
  ["<A-k>"] = "<C-W>k",
  ["<A-h>"] = "<C-W>h",
  ["<A-l>"] = "<C-W>l",
  ["<A-J>"] = "<C-W>10<i",
  ["<A-K>"] = "<C-W>10>i",
  ["<A-H>"] = "<C-W>5-i",
  ["<A-L>"] = "<C-W>5+i",
}

for k, v in pairs(window_management) do
  vim.keymap.set("t", k, "<C-\\><C-n>" .. v)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

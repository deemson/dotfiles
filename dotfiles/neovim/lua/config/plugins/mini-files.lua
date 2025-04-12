local mini_files = require("mini.files")
local oil = require("oil")

mini_files.setup()

local function get_current_dir()
  local dir = oil.get_current_dir()
  if dir == nil then
    -- get currently edited file's directory
    dir = vim.fn.expand("%:p:h")
  end
  return dir
end

vim.keymap.set("n", "<C-§>", mini_files.open, { desc = "MiniFiles" })
vim.keymap.set("n", "§", function()
  if vim.bo.filetype == "minifiles" then
    mini_files.close()
  else
    mini_files.open(get_current_dir())
  end
end, { desc = "MiniFiles current dir" })

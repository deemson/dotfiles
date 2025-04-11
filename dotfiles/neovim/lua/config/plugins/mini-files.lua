local mini_files = require("mini.files")
local oil = require("oil")

mini_files.setup()

local function get_current_dir()
  local dir = oil.get_current_dir()
  if dir == nil then
    dir = vim.fn.expand("%:p:h")
  end
  return dir
end

vim.keymap.set("n", "<C-§>", mini_files.open, { desc = "MiniFiles" })
vim.keymap.set("n", "§", function()
  mini_files.open(get_current_dir())
end, { desc = "MiniFiles current dir" })

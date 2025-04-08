local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = { border = "double" },
})

local function lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set({ "n", "t" }, "<A-g>", lazygit_toggle, { desc = "Lazygit" })

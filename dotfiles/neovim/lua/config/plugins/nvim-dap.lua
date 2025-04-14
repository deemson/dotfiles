local dap = require("dap")
local dapui = require("dapui")

require("dap-python").setup("python")
require('dap-go').setup()

local dap_group_key = "d"
local keymap = {
  { "b", dap.toggle_breakpoint, "Breakpoint" },
  { "c", dap.continue, "Continue" },
  { "u", dapui.toggle, "UI" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. dap_group_key .. k[1], k[2], { desc = k[3] })
end

local dap = require("dap")
local dapui = require("dapui")

require("dap-python").setup("python")
require("dap-go").setup()
require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

local dap_group_key = "d"
local keymap = {
  { "b", dap.toggle_breakpoint, "Breakpoint" },
  { "c", dap.continue, "Continue" },
  { "u", dapui.toggle, "UI" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. dap_group_key .. k[1], k[2], { desc = k[3] })
end

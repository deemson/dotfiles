local dap = require("dap")
local M = {}

---@class RemoteConfig
---@field key string
---@field name string
---@field port number
---@field remotePath string

--- @param config RemoteConfig
M.add_remote = function(config)
  dap.adapters[config.key] = {
    type = "server",
    host = "127.0.0.1",
    port = config.port,
  }
  local configs_table = dap.configurations.go or {}
  vim.list_extend(configs_table, {
    {
      type = config.key,
      name = config.name,
      request = "attach",
      mode = "remote",
      host = "127.0.0.1",
      port = config.port,
      substitutePath = {
        {
          from = "${workspaceFolder}",
          to = config.remotePath,
        },
      },
    },
  })
  dap.configurations.go = configs_table
end

return M

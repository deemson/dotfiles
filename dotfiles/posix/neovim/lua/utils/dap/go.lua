local dap = require("dap")
local M = {}

M.add_local = function()
  if dap.adapters.go_local ~= nil then
    vim.notify("Go local adapter already exists", vim.log.levels.ERROR)
    return
  end
  dap.adapters.go_local = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "--listen", "127.0.0.1:${port}" },
    },
  }
  dap.configurations.go = vim.list_extend(dap.configurations.go or {}, {
    {
      type = "go_local",
      name = "Debug file",
      request = "launch",
      program = "${file}",
    },
  })
end

---@class RemoteConfig
---@field key string
---@field name string
---@field port number
---@field remotePath string

--- @param config RemoteConfig
M.add_remote = function(config)
  if dap.adapters[config.key] ~= nil then
    vim.notify("Go debug adapter with key '" .. config.key .. "' already exists", vim.log.levels.ERROR)
    return
  end
  dap.adapters[config.key] = {
    type = "server",
    host = "127.0.0.1",
    port = config.port,
  }
  dap.configurations.go = vim.list_extend(dap.configurations.go or {}, {
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
end

return M

-- DAP is a debug adapter protocol client -- essentially a debugger for neovim
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
    "nvim-telescope/telescope-dap.nvim", -- telescope integration
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local telescope = require("telescope")

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "--listen", "127.0.0.1:${port}" },
      },
    }

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug package",
        request = "launch",
        program = "${workspaceFolder}",
      },
      {
        type = "go",
        name = "Attach",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }

    -- UI setup
    dapui.setup()

    -- Auto-open/close UI with session
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)
    vim.keymap.set("n", "<A-b>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>d", dapui.toggle)

    telescope.load_extension("dap")
  end,
}

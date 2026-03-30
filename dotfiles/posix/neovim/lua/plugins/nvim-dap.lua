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
    local neotreeCommand = require("neo-tree.command")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      neotreeCommand.execute({ action = "close" })
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
      neotreeCommand.execute({ action = "show" })
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      neotreeCommand.execute({ action = "show" })
    end

    -- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)
    vim.keymap.set("n", "<A-b>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", function()
      dapui.close()
      neotreeCommand.execute({ action = "show" })
    end, { desc = "Close" })
    vim.keymap.set("n", "<leader>do", function()
      neotreeCommand.execute({ action = "close" })
      dapui.open()
    end, { desc = "Open" })
    vim.keymap.set("n", "<leader>ds", dap.stop, { desc = "Stop" })
    vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "Disconnect" })

    telescope.load_extension("dap")
    local telescopeDap = telescope.extensions.dap
    vim.keymap.set("n", "<leader>db", telescopeDap.list_breakpoints, { desc = "Breakpoints" })
  end,
}

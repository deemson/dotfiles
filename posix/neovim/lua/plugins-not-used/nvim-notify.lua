-- nvim-notify provides a sleek notifications UI
return {
  "rcarriga/nvim-notify",
  lazy = false,
  enabled = false,
  config = function()
    local notify = require("notify")
    notify.setup({
      timeout = 2000,
      render = "minimal",
      stages = "static",
    })
    vim.keymap.set("n", "<leader>fn", "<Cmd>Telescope notify<CR>", { desc = "Notifications" })
    vim.keymap.set("", "<A-`>", notify.dismiss, { desc = "Dismiss Notification" })
  end,
}

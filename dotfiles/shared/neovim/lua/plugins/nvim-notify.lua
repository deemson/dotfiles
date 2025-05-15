-- nvim-notify provides a sleek notifications UI
return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local notify = require("notify")
    notify.setup()

    vim.keymap.set("", "<A-q>", notify.dismiss, { desc = "Dismiss Notification" })
  end,
}

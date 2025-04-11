local notify = require("notify")

vim.keymap.set("", "<A-c>", notify.dismiss, { desc = "Dismiss Notification" })

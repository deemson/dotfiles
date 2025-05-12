local notify = require("notify")
notify.setup()

vim.keymap.set("", "<A-q>", notify.dismiss, { desc = "Dismiss Notification" })

local neotest = require("neotest")

neotest.setup({
  icons = { passed = "o", failed = "x", running = ">", skipped = "-", unknown = "?" },
  adapters = { require("neotest-golang")({ runner = "gotestsum", go_test_args = {} }) },
})

local function neotest_output()
  neotest.output.open({ enter = true, auto_close = true })
end

vim.keymap.set("n", "<leader>ts", function()
  neotest.summary.toggle()
end, { desc = "summary" })
vim.keymap.set("n", "<leader>to", neotest_output, { desc = "output" })
vim.keymap.set("n", "<leader>tt", function()
  neotest.run.run()
end, { desc = "nearest" })
vim.keymap.set("n", "<leader>te", function()
  neotest.run.run(vim.fn.getcwd())
end, { desc = "everything in CWD" })

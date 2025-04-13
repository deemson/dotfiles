local neotest = require("neotest")

neotest.setup({
  icons = { passed = "o", failed = "x", running = ">", skipped = "-", unknown = "?" },
  adapters = { require("neotest-golang")({ runner = "gotestsum", go_test_args = {} }) },
})

local function neotest_summary()
  neotest.summary.toggle()
end

local function neotest_output()
  neotest.output.open({ enter = true, auto_close = true })
end

local function neotest_run_everything()
  neotest.run.run(vim.fn.getcwd())
end

local function neotest_run_nearest()
  neotest.run.run()
end

local neotest_group_key = "n"
local keymap = {
  { "n", neotest_run_nearest, "nearest" },
  { "e", neotest_run_everything, "everything in CWD" },
  { "o", neotest_output, "output" },
  { "s", neotest_summary, "summary" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. neotest_group_key .. k[1], k[2], { desc = k[3] })
end

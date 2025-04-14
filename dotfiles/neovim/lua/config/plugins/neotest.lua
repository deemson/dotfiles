local neotest = require("neotest")

neotest.setup({
  icons = {
    -- stylua: ignore start
    -- running_animated = { "⠄", "⠆", "⠇", "⠋", "⠙", "⠸", "⠰", "⠠", "⠰", "⠸", "⠙", "⠋", "⠇", "⠆" },
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    -- stylua: ignore end
  },
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

local function neotest_run_file()
  neotest.run.run(vim.fn.expand("%"))
end

local function neotest_run_nearest()
  neotest.run.run()
end

local function neotest_stop()
  neotest.run.stop()
end

local function neotest_debug_nearest()
  neotest.run.run({ strategy = "dap" })
end

local neotest_group_key = "n"
local keymap = {
  { "n", neotest_run_nearest, "nearest" },
  { "e", neotest_run_everything, "everything in CWD" },
  { "f", neotest_run_file, "file" },
  { "o", neotest_output, "output" },
  { "m", neotest_summary, "summary" },
  { "s", neotest_stop, "stop" },

  { "dn", neotest_debug_nearest, "nearest" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. neotest_group_key .. k[1], k[2], { desc = k[3] })
end

local neotest = require("neotest")

local cwd = vim.fn.getcwd()

local adapters = {
  require("neotest-vitest"),
}

if vim.fn.filereadable(cwd .. "/go.mod") then
  adapters[#adapters + 1] = require("neotest-golang")({
    runner = "gotestsum", -- go/gotestsum
    go_test_args = { "-v" },
    gotestsum_args = { "--format=standard-verbose" },
  })
end

---@diagnostic disable-next-line: missing-fields
neotest.setup({
  icons = {
    -- stylua: ignore start
    -- running_animated = { "⠄", "⠆", "⠇", "⠋", "⠙", "⠸", "⠰", "⠠", "⠰", "⠸", "⠙", "⠋", "⠇", "⠆" },
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    -- stylua: ignore end
  },
  adapters = adapters,
})

local function neotest_summary()
  neotest.summary.toggle()
end

local function neotest_output_panel()
  neotest.output_panel.toggle()
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
  ---@diagnostic disable-next-line: missing-fields
  neotest.run.run({ strategy = "dap" })
end

local function neotest_run_last()
  neotest.run.run_last()
end

local function neotest_debug_last()
  ---@diagnostic disable-next-line: missing-fields
  neotest.run.run_last({ strategy = "dap" })
end

local neotest_group_key = "n"
local keymap = {
  { "n", neotest_run_nearest, "nearest" },
  { "l", neotest_run_last, "last" },
  { "e", neotest_run_everything, "everything in CWD" },
  { "f", neotest_run_file, "file" },
  { "o", neotest_output, "output" },
  { "m", neotest_summary, "summary" },
  { "s", neotest_stop, "stop" },
  { "p", neotest_output_panel, "output panel" },

  { "dn", neotest_debug_nearest, "nearest" },
  { "dl", neotest_debug_last, "last" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. neotest_group_key .. k[1], k[2], { desc = k[3] })
end

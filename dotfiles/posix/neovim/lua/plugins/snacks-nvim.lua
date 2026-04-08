local function toggleExplorer()
  Snacks.explorer()
end

local function toggleNotifierHistory()
  Snacks.notifier.show_history()
end

local pickers = {
  file = function()
    Snacks.picker.files()
  end,
  grep = function()
    Snacks.picker.grep()
  end,
  lsp = {
    typeDef = function()
      Snacks.picker.lsp_type_definitions()
    end,
    def = function()
      Snacks.picker.lsp_definitions()
    end,
    ref = function()
      Snacks.picker.lsp_references()
    end,
    impl = function()
      Snacks.picker.lsp_implementations()
    end,
    calls = {
      inc = function()
        Snacks.picker.lsp_incoming_calls()
      end,
      out = function()
        Snacks.picker.lsp_outgoing_calls()
      end,
    },
  },
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    ---@class snacks.picker.Explorer
    explorer = {
      finder = false,
      enabled = true,
    },
    -- indent = { enabled = true },
    ---@class snacks.input.Config
    input = {
      enabled = true,
      win = {
        style = "input",
        keys = {
          -- ["<esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
    ---@class snacks.picker.Config
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<esc>"] = { "close", mode = { "n", "i" } },
            ["<c-a>"] = false,
            ["<a-f>"] = false,
          },
        },
      },
      sources = {
        explorer = {
          hidden = true,
          layout = {
            -- auto_hide = { "input" },
          },
          actions = {
            clear_input = function(picker)
              picker.input:set("", "")
              picker:find({
                refresh = false,
                on_done = function()
                  picker:focus("list", { show = true })
                end,
              })
            end,
          },
          win = {
            input = {
              keys = {
                ---@diagnostic disable-next-line: assign-type-mismatch
                ["<Esc>"] = { "clear_input", mode = { "n", "i" } },
                ["<CR>"] = { "confirm", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<Esc>"] = false,
                ["/"] = false,
                ["."] = false,
                ["<BS>"] = false,
                ["<a-h>"] = false,
              },
            },
          },
        },
      },
    },
    ---@class snacks.notifier.Config
    ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
    ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
    notifier = {
      enabled = true,
      timeout = 2000,
      style = "minimal",
    },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    styles = {
      input = {
        keys = {
          i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
        },
      },
    },
  },
  keys = {
    -- File Explorer
    { "<F2>", toggleExplorer, desc = "File Explorer" },
    -- Find
    { "<leader>ff", pickers.file, desc = "Files" },
    { "<leader>fe", pickers.grep, desc = "Grep" },
    { "<leader>fn", toggleNotifierHistory, desc = "Notifications" },
    -- LSP
    { "<leader>lt", pickers.lsp.typeDef, desc = "Type Definitions" },
    { "<leader>ld", pickers.lsp.def, desc = "Definitions" },
    { "<leader>lr", pickers.lsp.ref, desc = "References" },
    { "<leader>li", pickers.lsp.impl, desc = "Implementations" },
    { "<leader>l,", pickers.lsp.calls.inc, desc = "Incoming Calls" },
    { "<leader>l.", pickers.lsp.calls.out, desc = "Outgoing Calls" },
  },
}

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({})

    local function add()
      harpoon:list():add()
    end

    local function next()
      harpoon:list():next()
    end

    local function prev()
      harpoon:list():prev()
    end

    local function menu()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end

    local harpoon_group_key = "h"
    local keymap = {
      { "a", add, "Add File" },
      { "n", next, "Next" },
      { "p", prev, "Prev" },
      { "m", menu, "Quick Menu" },
    }

    for _, k in ipairs(keymap) do
      vim.keymap.set("n", "<leader>" .. harpoon_group_key .. k[1], k[2], { desc = k[3] })
    end
  end,
}

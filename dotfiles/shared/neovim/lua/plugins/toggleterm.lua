return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    -- key mapping to easily exit insert mode in terminal
    vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

    require("toggleterm").setup({
      shade_terminals = false,
      persist_mode = false,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local terminal = Terminal:new({
      hidden = true,
      direction = "float",
      float_opts = { border = "double" },
    })
    vim.keymap.set({ "t", "n" }, "<A-T>", function()
      local dir = vim.fn.expand("%:p:h")
      terminal:toggle()
      if terminal:is_open() then
        terminal:change_dir(dir)
        terminal:scroll_bottom()
      end
    end, { desc = "Terminal" })
    vim.keymap.set({ "t", "n" }, "<A-t>", function()
      terminal:toggle()
      if terminal:is_open() then
        terminal:change_dir(vim.fn.getcwd())
        terminal:scroll_bottom()
      end
    end, { desc = "Terminal" })

    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = { border = "double" },
    })

    vim.keymap.set({ "t", "n" }, "<A-g>", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })
  end,
}

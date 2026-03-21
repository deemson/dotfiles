-- readline motions and deletions in Neovim (emacs-like)
return {
  "assistcontrol/readline.nvim",
  init = function()
    local readline = require("readline")
    local keymap = {
      ["M-f"] = readline.forward_word,
      ["M-b"] = readline.backward_word,
      ["C-a"] = readline.dwim_beginning_of_line,
      ["C-e"] = readline.end_of_line,
      ["M-d"] = readline.kill_word,
      ["M-BS"] = readline.backward_kill_word,
      ["C-k"] = readline.kill_line,
      ["C-u"] = readline.backward_kill_line,
    }
    for k, v in pairs(keymap) do
      vim.keymap.set("!", "<" .. k .. ">", v)
    end
  end,
}

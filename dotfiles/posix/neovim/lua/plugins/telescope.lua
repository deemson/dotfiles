-- telescope fuzzy finds anything (files, buffers, etc.)
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    local live_grep = function(...)
      return builtin.live_grep({
        ...,
        additional_args = function()
          return {
            "--no-ignore",
            "--hidden",
            "--max-filesize",
            "500K",
          }
        end,
      })
    end

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-u>"] = false,
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
    })

    local keymap = {
      f = {
        { "f", builtin.find_files, "Find Files" },
        { "e", live_grep, "Live Grep" },
        { "b", builtin.buffers, "Buffers" },
        { "?", builtin.help_tags, "Help Tags" },
        { "t", builtin.treesitter, "Treesitter" },
        { "r", builtin.registers, "Registers" },
      },
      l = {
        { "t", builtin.lsp_type_definitions, "Type Definitions" },
        { "d", builtin.lsp_definitions, "Definitions" },
        { "r", builtin.lsp_references, "References" },
        { "i", builtin.lsp_implementations, "Implementations" },
        { ",", builtin.lsp_incoming_calls, "Incoming Calls" },
        { ".", builtin.lsp_outgoing_calls, "Outgoing Calls" },
      },
    }

    for group_key, group_keymap in pairs(keymap) do
      for _, k in ipairs(group_keymap) do
        vim.keymap.set("n", "<leader>" .. group_key .. k[1], k[2], { desc = k[3] })
      end
    end
  end,
}

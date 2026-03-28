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

    local telescope_group_key = "t"
    local keymap = {
      { "f", builtin.find_files, "Find Files" },
      { "e", live_grep, "Live Grep" },
      { "b", builtin.buffers, "Buffers" },
      { "?", builtin.help_tags, "Help Tags" },

      { "t", builtin.treesitter, "Treesitter" },

      { "gs", builtin.git_status, "Status" },

      { "ld", builtin.lsp_definitions, "Definitions" },
      { "lr", builtin.lsp_references, "References" },
      { "li", builtin.lsp_implementations, "Implementations" },
      { "l,", builtin.lsp_incoming_calls, "Incoming Calls" },
      { "l.", builtin.lsp_outgoing_calls, "Outgoing Calls" },
    }

    for _, k in ipairs(keymap) do
      vim.keymap.set("n", "<leader>" .. telescope_group_key .. k[1], k[2], { desc = k[3] })
    end
  end,
}

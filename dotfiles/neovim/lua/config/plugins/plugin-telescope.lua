local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

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
  { "e", builtin.live_grep, "Live Grep" },
  { "b", builtin.buffers, "Buffers" },
  { "?", builtin.help_tags, "Help Tags" },

  { "gs", builtin.git_status, "Status" },
}

for _, k in ipairs(keymap) do
  vim.keymap.set("n", "<leader>" .. telescope_group_key .. k[1], k[2], { desc = k[3] })
end

local builtin = require("telescope.builtin")

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

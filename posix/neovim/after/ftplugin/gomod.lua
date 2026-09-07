require("utils.textobjects").setup_buf({
  select = { "block", "parameter", "statement", "assignment", "comment" },
  move = { "block" },
})

require("utils.textobjects").setup_buf({
  select = { "function", "class", "block", "call", "parameter", "assignment", "comment", "conditional", "loop", "statement" },
  move = { "function", "class" },
})

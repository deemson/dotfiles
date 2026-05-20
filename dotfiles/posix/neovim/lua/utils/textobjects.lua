-- Per-buffer textobject keymaps using nvim-treesitter-textobjects (main branch).
-- Use from after/ftplugin/<lang>.lua to enable only the features that make sense
-- for the language:
--
--   require("utils.textobjects").setup_buf({
--     select = { "function", "block", "call", "parameter", "assignment",
--                "comment", "conditional", "loop", "statement" },
--     move   = { "function" },
--   })
--
-- Available features:
--   "function"    -> af / if  + ]f / [f (move)
--   "class"       -> ac / ic  + ]c / [c (move)
--   "loop"        -> al / il
--   "conditional" -> ai / ii
--   "block"       -> ab / ib
--   "call"        -> a. / i.
--   "parameter"   -> a, / i,
--   "assignment"  -> a= / i=  and  =[ / =]  (lhs / rhs)
--   "comment"     -> a/ / i/
--   "statement"   -> s

local M = {}

local features = {
  ["function"] = {
    select = { ["af"] = "@function.outer", ["if"] = "@function.inner" },
    move = {
      next_start = { ["]f"] = "@function.outer" },
      prev_start = { ["[f"] = "@function.outer" },
    },
  },
  class = {
    select = { ["ac"] = "@class.outer", ["ic"] = "@class.inner" },
    move = {
      next_start = { ["]c"] = "@class.outer" },
      prev_start = { ["[c"] = "@class.outer" },
    },
  },
  loop = {
    select = { ["al"] = "@loop.outer", ["il"] = "@loop.inner" },
  },
  conditional = {
    select = { ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner" },
  },
  block = {
    select = { ["ab"] = "@block.outer", ["ib"] = "@block.inner" },
  },
  call = {
    select = { ["a."] = "@call.outer", ["i."] = "@call.inner" },
  },
  parameter = {
    select = { ["a,"] = "@parameter.outer", ["i,"] = "@parameter.inner" },
  },
  assignment = {
    select = {
      ["a="] = "@assignment.outer",
      ["i="] = "@assignment.inner",
      ["=["] = "@assignment.lhs",
      ["=]"] = "@assignment.rhs",
    },
  },
  comment = {
    select = { ["a/"] = "@comment.outer", ["i/"] = "@comment.inner" },
  },
  statement = {
    select = { ["s"] = "@statement.outer" },
  },
}

local function set_select(lhs, query)
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end, { buffer = 0, silent = true, desc = "Select " .. query })
end

local function set_move_next(lhs, query)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_next_start(query, "textobjects")
  end, { buffer = 0, silent = true, desc = "Next " .. query .. " start" })
end

local function set_move_prev(lhs, query)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_previous_start(query, "textobjects")
  end, { buffer = 0, silent = true, desc = "Prev " .. query .. " start" })
end

---@param opts { select?: string[], move?: string[] }
function M.setup_buf(opts)
  opts = opts or {}

  for _, name in ipairs(opts.select or {}) do
    local f = features[name]
    if f and f.select then
      for lhs, query in pairs(f.select) do
        set_select(lhs, query)
      end
    else
      vim.notify("textobjects: unknown select feature '" .. name .. "'", vim.log.levels.WARN)
    end
  end

  for _, name in ipairs(opts.move or {}) do
    local f = features[name]
    if f and f.move then
      for lhs, query in pairs(f.move.next_start or {}) do
        set_move_next(lhs, query)
      end
      for lhs, query in pairs(f.move.prev_start or {}) do
        set_move_prev(lhs, query)
      end
    else
      vim.notify("textobjects: feature '" .. name .. "' has no move bindings", vim.log.levels.WARN)
    end
  end
end

return M

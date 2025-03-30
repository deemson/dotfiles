-- set space as <leader> key
vim.g.mapleader = ' '

-- yank to system buffer
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

-- open tree on the left via F2
vim.keymap.set('n', '<F2>', '<Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

-- keymaps for buffer control, useful when working with barbar plugin
local buffer_keys = {
  { 'A-,', 'BufferPrevious' },
  { 'A-.', 'BufferNext' },
  { 'A-C-,', 'BufferMovePrevious' },
  { 'A-C-.', 'BufferMoveNext' },
  { 'A-1', 'BufferGoto 1' },
  { 'A-2', 'BufferGoto 2' },
  { 'A-3', 'BufferGoto 3' },
  { 'A-4', 'BufferGoto 4' },
  { 'A-5', 'BufferGoto 5' },
  { 'A-6', 'BufferGoto 6' },
  { 'A-7', 'BufferGoto 7' },
  { 'A-8', 'BufferGoto 8' },
  { 'A-9', 'BufferGoto 9' },
  { 'A-0', 'BufferLast' },
  { 'A-c', 'BufferClose' }
}
for _, k in ipairs(buffer_keys) do
  vim.keymap.set('n', '<' .. k[1] .. '>', '<Cmd>' .. k[2] .. '<CR>', { noremap = true, silent = false })
end

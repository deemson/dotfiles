local keys = {
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
for _, k in ipairs(keys) do
  vim.keymap.set('n', '<' .. k[1] .. '>', '<Cmd>' .. k[2] .. '<CR>', { noremap = true, silent = false })
end

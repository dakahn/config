local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

vim.g.mapleader = ' '
map('i', 'jk', '<Esc>')
map('n', '<leader>s', ':Sex<cr>')
map('n', '<Esc>', ':noh<cr>')
-- keep cursor in the middle
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')
-- split nav
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

map('n', '<leader>p', ':Telescope find_files<cr>')
map('n', '<leader>g', ':Telescope live_grep<cr>')
map('n', '<leader>f', ':Prettier<cr>')
map('n', '<leader>b', ':Telescope buffers<cr>')
map('n', '<leader>t', ':Twilight<cr>')

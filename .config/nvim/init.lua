-- PLUGINS ---------------------------------------------------------------
--------------------------------------------------------------------------
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  use 'itchyny/vim-gitbranch'
  use 'tpope/vim-commentary'
  use "lewis6991/gitsigns.nvim"
  use "phaazon/hop.nvim"
  use "jiangmiao/auto-pairs"
  use 'sbdchd/neoformat'
  use 'kyazdani42/nvim-web-devicons'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'jxnblk/vim-mdx-js'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
  use 'nvim-lualine/lualine.nvim'
  use 'styled-components/vim-styled-components'
  use 'Glench/Vim-Jinja2-Syntax'
  use 'sainnhe/everforest'
end)

require('hop').setup()
require('gitsigns').setup()
require('telescope').setup()
require("indent_blankline").setup()
require("lualine").setup()

-- SETTINGS --------------------------------------------------------------
--------------------------------------------------------------------------
vim.cmd([[
  set statusline=\ %f\ %{gitbranch#name()}%m%=\ %R%y%W\ %6l:%-2c\ 
]])
vim.cmd([[
  autocmd BufWritePre *.js Neoformat
]])
vim.cmd([[
  let g:neoformat_try_node_exe = 1
]])
-- Diagnostic feedback
vim.diagnostic.config {
  virtual_text = false,
  -- signs = false,
  underline = false,
}
vim.g.neoformat_try_node_exe = 1
vim.cmd[[colorscheme everforest]]
vim.opt.signcolumn = 'yes:1'
vim.opt.termguicolors = true
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 20
vim.opt.laststatus = 2
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.nu = true
vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'UTF-8'
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.title = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.so = 7
vim.opt.wildmode = { list = {'longest'}}
vim.opt.wildmenu = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.wb = false
vim.opt.backup = false
vim.opt.cursorline = true
vim.opt.writebackup = false
vim.o.shortmess = vim.o.shortmess .. "c"
vim.opt.updatetime = 100

-- KEYMAPS ---------------------------------------------------------------
--------------------------------------------------------------------------
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

map('n', '<leader>p', ':Telescope find_files theme=dropdown<cr>')
map('n', '<leader>g', ':Telescope live_grep theme=dropdown<cr>')
map('n', '<leader>h', ':HopWord<cr>')
map('n', '<leader>f', ':Neoformat<cr>')
map('n', '<leader>b', ':Telescope buffers theme=dropdown<cr>')


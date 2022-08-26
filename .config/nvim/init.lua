--------------------------------------------------------------
---------------------------------------------------plugins----
--------------------------------------------------------------
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  use 'itchyny/vim-gitbranch'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'tpope/vim-commentary'
  use "lewis6991/gitsigns.nvim"
  use "phaazon/hop.nvim"
  use "jiangmiao/auto-pairs"
  use 'sbdchd/neoformat'
  use 'windwp/nvim-ts-autotag'
  use 'tpope/vim-vinegar'
  use 'kyazdani42/nvim-web-devicons'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'jxnblk/vim-mdx-js'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  use 'nvim-lualine/lualine.nvim'
end)

require('hop').setup()
require('gitsigns').setup()
require('telescope').setup()
require('nvim-ts-autotag').setup()
require('lualine').setup()
require("indent_blankline").setup()
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

--------------------------------------------------------------
--------------------------------------------------settings---- 
--------------------------------------------------------------
vim.cmd([[
  set statusline=%t\ %{gitbranch#name()}\ %=\ %m%r%y%w\ %4l:%-2c
]])
vim.cmd([[
  autocmd BufWritePre *.js Neoformat
]])
vim.g.neoformat_try_node_exe = 1
vim.cmd[[colorscheme sonokai]]
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

--------------------------------------------------------------
---------------------------------------------------keymaps---- 
--------------------------------------------------------------
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
map('n', '<leader>h', ':HopWord<cr>')
map('n', '<leader>f', ':Neoformat<cr>')
map('n', '<leader>b', ':Telescope buffers<cr>')

--------------------------------------------------------------
------------------------------------------------treesitter---- 
--------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'lua',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true
  }
})

require "paq" {
  'savq/paq-nvim';
  'neovim/nvim-lspconfig';
  'williamboman/nvim-lsp-installer';
  'hrsh7th/cmp-nvim-lsp';
  'nvim-telescope/telescope.nvim';
  'nvim-lua/plenary.nvim';
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  {'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate'};
  'tpope/vim-commentary';
  'tpope/vim-fugitive';
  {'prettier/vim-prettier', ['do'] = 'yarn install --frozen-lockfile --production' };
  'lewis6991/gitsigns.nvim';
  'nvim-lualine/lualine.nvim';
  'phaazon/hop.nvim';
  'tpope/vim-vinegar';
  'kyazdani42/nvim-web-devicons';
  'jxnblk/vim-mdx-js';
}

vim.cmd('packadd! dracula_pro')
require('lualine').setup()
require('gitsigns').setup()
require('telescope').setup()
require'hop'.setup()

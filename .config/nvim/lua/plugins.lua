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
  'tpope/vim-commentary';
  'tpope/vim-fugitive';
  {'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate'};
  {'prettier/vim-prettier', ['do'] = 'yarn install --frozen-lockfile --production' };
  'lewis6991/gitsigns.nvim';
  'navarasu/onedark.nvim';
  'phaazon/hop.nvim';
  'tpope/vim-vinegar';
  'kyazdani42/nvim-web-devicons';
  'jxnblk/vim-mdx-js';
}

require('gitsigns').setup()
require('telescope').setup()
require'hop'.setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true, 
  },
}

require("twilight").setup()

local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  },
})
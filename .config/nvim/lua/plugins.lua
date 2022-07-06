vim.cmd [[
augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end
]]

vim.cmd('packadd! dracula_pro')
require('lualine').setup()
require('gitsigns').setup()
require('telescope').setup{
  pickers = {
    live_grep = {
      theme = "dropdown",
    },
    git_files = {
      theme = "dropdown",
    }
  },
}
require'hop'.setup()

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use {
    'prettier/vim-prettier',
    run = 'yarn install --frozen-lockfile --production'
  }
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'phaazon/hop.nvim'
  use 'tpope/vim-vinegar'
  use 'kyazdani42/nvim-web-devicons'
  use 'jxnblk/vim-mdx-js'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
end)


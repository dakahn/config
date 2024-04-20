vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- PLUGINS ---------------------------------------------------------------
--------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',   
  'tpope/vim-sleuth',    
  'tpope/vim-vinegar',  
  'jiangmiao/auto-pairs',
  'itchyny/vim-gitbranch',
	'sbdchd/neoformat',
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'dark', 
      }
      require('onedark').load()
    end,
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {},
  },
  {     
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  { 'numToStr/Comment.nvim', opts = {} }, 
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
}, {})

-- SETS -----------------------------------------------------------------------
-------------------------------------------------------------------------------
vim.cmd([[
  set statusline=\ %f\ %{gitbranch#name()}%m%=\ %R%y%W\ %6l:%-2c\ 
]])
vim.o.textwidth = 80 
vim.o.linebreak = true
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.showmode = false
vim.o.hlsearch = false                 -- Set highlight on search
vim.wo.number = true                   -- Make line numbers default
vim.o.mouse = 'a'                      -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'              -- Keep signcolumn on by default
vim.o.updatetime = 250                 -- Decrease update time
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.termguicolors = true             -- NOTE: You should make sure your terminal supports this
vim.g.markdown_recommended_style = 0   -- Fix markdown indentation style
vim.g.neoformat_try_node_exe = 1       -- Use local not global Prettier install

-- Configs --------------------------------------------------------------------
-------------------------------------------------------------------------------
-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = require('telescope.themes').get_dropdown {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- KEYMAPS --------------------------------------------------------------------
-------------------------------------------------------------------------------
local function map(mode, combo, mapping, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<Esc>', ':noh<cr>')

-- Split navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Plugins 
map("n", "<leader><leader>", ":Telescope find_files theme=dropdown<cr>")
map("n", "<leader>g", ":Telescope live_grep theme=dropdown<cr>")
map("n", "<leader>h", ":HopWord<cr>")
map("n", "<leader>b", ":Telescope buffers theme=dropdown<cr>")
map("n", "<leader>f", ":Neoformat<cr>")

-- vim: ts=2 sts=2 sw=2 et

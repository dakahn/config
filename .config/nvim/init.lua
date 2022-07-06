require('packer').startup(function()
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
  use 'joshdick/onedark.vim'

end)

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




vim.cmd('colorscheme onedark')
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
-- vim.opt.signcolumn = 'yes:1'
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
vim.opt.cursorline = false
vim.opt.writebackup = false
vim.o.shortmess = vim.o.shortmess .. "c"
vim.opt.updatetime = 100

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

map('n', '<leader>p', ':Telescope git_files<cr>')
map('n', '<leader>g', ':Telescope live_grep<cr>')
map('n', '<leader>f', ':Prettier<cr>')
map('n', '<leader>b', ':Telescope buffers<cr>')
map('n', '<leader>t', ':Twilight<cr>')





local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

function default_on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    -- border = 'single'
  }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})


local config = {}

-- Setup
require('nvim-lsp-installer').on_server_ready(function (server)
  local opts = {
    capabilities = capabilities,
    on_attach = default_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }

  if config[server.name] then
    opts = vim.tbl_deep_extend('force', opts, config[server.name])
  end

  server:setup(opts)

  vim.cmd [[ do User LspAttachBuffers ]]
end)




require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'css',
    'dockerfile',
    'elixir',
    'go',
    'gomod',
    'graphql',
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
  },
  indent = {
    enable = false,
  },
  context_commentstring = {
    enable = true,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
    },
    highlight_current_scope = {
      enable = false,
    },
  },
})

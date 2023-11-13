" PLUGINS
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-sneak'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/vim-cursorword'
Plug 'ap/vim-css-color'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'sainnhe/everforest'
Plug 'airblade/vim-gitgutter'
call plug#end()

" CONFIGS
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
if has('termguicolors')
  set termguicolors
endif
set background=dark
syntax on
colorscheme everforest 
set laststatus=2
set statusline=\ %f\ %{FugitiveStatusline()}%m%=\ %R%y%W\ %6l:%-2c\ 
set number
set completeopt=menu,menuone,noselect
set wrap
set hidden
set signcolumn=auto
set clipboard^=unnamed,unnamedplus
set encoding=UTF-8
set splitbelow
set splitright
set ignorecase
set smartcase
set title
set ruler
set so=7
set wildmode=list:longest,list:full
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set noswapfile
set nobackup
set nowritebackup
set shortmess+=c
set updatetime=100

" REMAPS
let mapleader = " "
inoremap jk <Esc>
" keep cursor in the middle
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" move text
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" folding
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <Tab> za
" fzf
nnoremap <leader><leader> :GFiles<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>b :Buffers<cr>

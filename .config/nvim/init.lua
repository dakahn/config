-- PLUGINS ---------------------------------------------------------------
--------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}) end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"sainnhe/everforest",
	"lukas-reineke/indent-blankline.nvim",
	"kyazdani42/nvim-web-devicons",
	"sbdchd/neoformat",
	"jiangmiao/auto-pairs",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-commentary",
  "tpope/vim-vinegar",
	"itchyny/vim-gitbranch",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",
	"rcarriga/nvim-notify",
	"stevearc/dressing.nvim",
	"phaazon/hop.nvim",
	"nvim-lualine/lualine.nvim",
  "folke/trouble.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, 
			{ "williamboman/mason.nvim" }, 
			{ "williamboman/mason-lspconfig.nvim" }, 

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, 
			{ "hrsh7th/cmp-nvim-lsp" }, 
			{ "hrsh7th/cmp-buffer" }, 
			{ "hrsh7th/cmp-path" }, 
			{ "saadparwaiz1/cmp_luasnip" }, 
			{ "hrsh7th/cmp-nvim-lua" }, 
		},
	},
})

require("lualine").setup({
	sections = {
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
vim.cmd([[colorscheme everforest]])
require("hop").setup()
-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")
lsp.preset("recommended")
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

-- SETTINGS --------------------------------------------------------------
--------------------------------------------------------------------------
-- vim.cmd([[
--   set statusline=\ %f\ %{gitbranch#name()}%m%=\ %R%y%W\ %6l:%-2c\
-- ]])
vim.cmd([[
  autocmd BufWritePre *.js Neoformat
]])
vim.cmd([[
  let g:neoformat_try_node_exe = 1
]])
-- Diagnostic feedback
vim.diagnostic.config({
	virtual_text = false,
	-- signs = false,
	underline = false,
})
vim.g.neoformat_try_node_exe = 1
vim.cmd([[colorscheme everforest]])
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- enable auto write
opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.cmdheight = 1
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guifont = "FiraCode Nerd Font:h11"
opt.hidden = true -- Enable modified buffers in background
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.joinspaces = false -- No double spaces with join after a dot
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess = "filnxtToOFWIcC"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- KEYMAPS ---------------------------------------------------------------
--------------------------------------------------------------------------
local function map(mode, combo, mapping, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

vim.g.mapleader = " "
map("i", "jk", "<Esc>")
map("n", "<leader>s", ":Sex<cr>")
map("n", "<Esc>", ":noh<cr>")
-- keep cursor in the middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
-- split nav
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")
-- plugins
map("n", "<leader><leader>", ":Telescope find_files theme=dropdown<cr>")
map("n", "<leader>g", ":Telescope live_grep theme=dropdown<cr>")
map("n", "<leader>h", ":HopWord<cr>")
map("n", "<leader>f", ":Neoformat<cr>")
map("n", "<leader>b", ":Telescope buffers theme=dropdown<cr>")
map("n", "<leader>t", ":TroubleToggle<cr>")

-- AUTOCOMMANDS ----------------------------------------------------------
--------------------------------------------------------------------------
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

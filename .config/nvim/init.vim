call plug#begin()

Plug 'nvim-tree/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-surround'
Plug 'whonore/Coqtail'
Plug 'rhysd/vim-clang-format'
Plug 'chrisbra/csv.vim'
Plug 'lervag/vimtex'
Plug 'jphustman/dbext.vim'

call plug#end()

set number

set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

filetype plugin on
filetype indent on
syntax on

set clipboard+=unnamedplus

colorscheme alduin
set termguicolors

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

set grepprg=grep\ -nH\ $*

lua require("nvim-tree").setup()
lua require('gitsigns').setup()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='alduin'
let g:airline_powerline_fonts = 1
set noshowmode
set laststatus=3

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:coc_global_extensions = ['coc-clangd', 'coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-ltex', '@yaegassy/coc-marksman', 'coc-texlab', 'coc-cmake', 'coc-sh']
let g:coc_filetype_map = {'tex': 'latex'}
let g:ale_ignore_lsp = 1

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

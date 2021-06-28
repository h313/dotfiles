call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'chrisbra/csv.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-latex/vim-latex'
Plug 'rhysd/vim-clang-format'
Plug 'jphustman/dbext.vim'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'

call plug#end()

set number

set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

filetype plugin on
syntax on

set clipboard+=unnamedplus

colorscheme alduin
set termguicolors

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='alduin'
let g:airline_powerline_fonts = 1

let g:Show_diagnostics_ui = 1

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


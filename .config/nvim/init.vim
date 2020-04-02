call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer --ts-completer' }
Plug 'chrisbra/csv.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-latex/vim-latex'
Plug 'rhysd/vim-clang-format'
Plug 'jphustman/dbext.vim'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'

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

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='alduin'

let g:ycm_register_as_syntastic_checker = 1
let g:Show_diagnostics_ui = 1

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'
nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:clang_format#code_style = 'llvm'
let g:ycm_use_clangd = 'Always'

" Wayland clipboard provider that strips carriage returns (GTK3 issue).
" This is needed because currently there's an issue where GTK3 applications on
" Wayland contain carriage returns at the end of the lines (this is a root
" issue that needs to be fixed).
let g:clipboard = {
      \   'name': 'wayland-strip-carriage',
      \   'copy': {
      \      '+': 'wl-copy --foreground --type text/plain',
      \      '*': 'wl-copy --foreground --type text/plain --primary',
      \    },
      \   'paste': {
      \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
      \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
      \   },
      \   'cache_enabled': 1,
      \ }

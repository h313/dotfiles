set number

set shiftwidth=2
set tabstop=4
set autoindent
set smartindent

filetype plugin on
syntax on

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

let g:airline_powerline_fonts = 1

let g:ycm_register_as_syntastic_checker = 1
let g:Show_diagnostics_ui = 1

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
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

require('plugins')
require('keybinds')

vim.opt.clipboard:append {'unnamedplus'}
vim.opt.mouse = 'a'

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.signcolumn = 'number'
vim.opt.updatetime = 100

vim.cmd('filetype plugin indent on')
vim.cmd('set noshowmode')

vim.o.background = 'dark'
vim.cmd([[colorscheme alduin]])
vim.opt.termguicolors = true

vim.opt.grepprg = 'grep\\ -nH\\ $*'

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_theme'] = 'alduin'

vim.opt.conceallevel = 1
vim.g.tex_flavor = 'latex'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = 'abdmg'

vim.g.ale_ignore_lsp = 1
vim.g.coc_global_extensions = {
  'coc-clangd',
  'coc-pyright',
  'coc-sh',
  'coc-sumneko-lua',
  'coc-cmake',
  'coc-tsserver',
  'coc-json',
  'coc-html',
  'coc-css',
  '@yaegassy/coc-marksman',
  'coc-texlab',
  'coc-ltex'
}

vim.cmd([[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
]])

vim.opt.foldmethod = 'expr'
vim.opt.foldenable = false
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end
})


require('plugins')
require('lsp')
require('keybinds')

vim.opt.clipboard:append {'unnamedplus'}
vim.o.mouse = 'a'

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true
vim.o.laststatus = 3
vim.o.signcolumn = 'number'
vim.o.updatetime = 100
vim.o.completeopt = "menuone,noselect,noinsert,popup,fuzzy"

vim.cmd('filetype plugin indent on')
vim.cmd('set noshowmode')

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd([[colorscheme alduin]])

vim.opt.grepprg = 'grep\\ -nH\\ $*'

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_theme'] = 'alduin'

vim.opt.conceallevel = 1
vim.g.tex_flavor = 'xelatex'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = 'abdmg'

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


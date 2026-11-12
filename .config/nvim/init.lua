vim.g.mapleader = '\\'

require('plugins')
require('lsp')
require('keybinds')

vim.cmd('call py3eval(\'0\')')

vim.opt.clipboard:append {'unnamedplus'}
vim.o.mouse = 'a'

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.laststatus = 3
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.statuscolumn = '%=%{v:relnum ? v:relnum : v:lnum} %s'
vim.o.updatetime = 100
vim.o.completeopt = 'menu,menuone'

vim.o.showmode = false

-- alduin sets background=dark itself; termguicolors is auto-detected
vim.cmd.colorscheme('alduin')

vim.opt.conceallevel = 1
vim.g.tex_flavor = 'latex'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = 'abdmg'

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  callback = function() vim.hl.on_yank() end,
})

vim.opt.foldenable = false

vim.filetype.add({ extension = { fpp = 'fpp', fppi = 'fpp' } })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
    },
    config = function()
      require('mason').setup()
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip'
    },
    event = 'InsertEnter'
  },

  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-lspconfig'
    },
    config = function()
      require('lspsaga').setup({})
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'c',
          'cmake',
          'cpp',
          'css',
          'gitcommit',
          'gitignore',
          'html',
          'json',
          'latex',
          'llvm',
          'make',
          'markdown',
          'markdown_inline',
          'python',
          'toml',
          'verilog',
          'vim'
        },
        sync_install = true,
        auto_install = false,
        highlight = {
          enable = true,
        },
      })
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('nvim-tree').setup()
    end
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('trouble').setup()
    end
  },

  {
    'vim-airline/vim-airline',
    lazy = false,
    priority = 1000,
    dependencies = {
      { 'vim-airline/vim-airline-themes' },
      { 'nvim-tree/nvim-web-devicons' }
    },
    config = function ()
      vim.g['airline#extensions#tabline#enabled'] = true
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    run = function()
      require('gitsigns').setup()
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  },

  { 'junegunn/goyo.vim' },

  { 'lervag/vimtex' },

  { 'whonore/Coqtail' }
}

require('lazy').setup(plugins, {
  ui = {
    border = 'rounded',
  },
  checker = { enabled = true },
  change_detection = { notify = false },
  install = { colorscheme = { 'alduin' } },
  debug = true
})

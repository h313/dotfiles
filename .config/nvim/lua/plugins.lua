local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use {
    'williamboman/mason.nvim',
    run = ':MasonUpdate',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
    },
    config = function()
      require('mason').setup()
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip'
    }
  }

  use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({})
    end,
  })

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        require('null-ls').setup()
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
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
          'toml',
          'verilog',
          'vim'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup()
    end
  }

  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end
  }

  use {
    'vim-airline/vim-airline',
    requires = {
      'vim-airline/vim-airline-themes',
    },
  }

  use {
    'lewis6991/gitsigns.nvim',
    run = function()
      require('gitsigns').setup()
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require('nvim-surround').setup()
    end
  }

  use { 'junegunn/goyo.vim' }

  use { 'lervag/vimtex' }

  use { 'whonore/Coqtail' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

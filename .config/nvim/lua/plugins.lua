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
  use 'wbthomason/packer.nvim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use {
    'dense-analysis/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "bash", "c", "cmake", "cpp", "gitcommit", "gitignore", "json", "latex", "llvm", "make", "markdown", "verilog", "vim"},
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
      require("nvim-tree").setup()
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
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end
  }

  use {'junegunn/goyo.vim'}

  use {'lervag/vimtex'}

  use {'whonore/Coqtail'}

  if packer_bootstrap then
    require('packer').sync()
  end
end)

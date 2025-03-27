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
          'asm',
          'bash',
          'c',
          'cmake',
          'cpp',
          'css',
          'gitcommit',
          'gitignore',
          'gpg',
          'html',
          'http',
          'java',
          'javascript',
          'json',
          'lua',
          'latex',
          'llvm',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'ninja',
          'objdump',
          'printf',
          'python',
          'systemtap',
          'tablegen',
          'tmux',
          'toml',
          'typescript',
          'verilog',
          'vim',
          'yaml'
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
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]o"] = "@loop.*",
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            }
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        }
      }
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

  { 'LunarVim/bigfile.nvim' },

  { 'tpope/vim-fugitive' },

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

-- Coqtail stays installed (below) for ftdetect/syntax/basic ftplugin only;
-- vsrocq.nvim handles actual proof interaction. Must be set before Coqtail loads.
vim.g.loaded_coqtail = 1
vim.g.coqtail_supported = 0

vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',

  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.10') },
  'https://github.com/rafamadriz/friendly-snippets',

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },

  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/folke/snacks.nvim',

  'https://github.com/nvim-lualine/lualine.nvim',

  'https://github.com/lewis6991/gitsigns.nvim',

  'https://github.com/ibhagwan/fzf-lua',

  'https://github.com/kylechui/nvim-surround',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/lervag/vimtex',
  'https://github.com/whonore/Coqtail',
  'https://github.com/tomtomjhj/vsrocq.nvim',
})

-- Plugin configuration

require('mason').setup()

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'normal'
  },
  completion = { documentation = { auto_show = false } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
})

require('nvim-treesitter.config').setup({
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
    'systemverilog',
    'tablegen',
    'tmux',
    'toml',
    'typescript',
    'vim',
    'yaml'
  },
  sync_install = true,
  auto_install = false,
  highlight = {
    enable = true,
  },
})

require('nvim-treesitter.config').setup({
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
})

require('trouble').setup()

require('snacks').setup({
  explorer = {},
  zen = {},
  image = { enabled = true },
})

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = true,
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        buffers_color = {
          active = 'Visual',
          inactive = 'TabLine',
        },
      },
    },
    lualine_z = {
      {
        'tabs',
        tabs_color = {
          active = 'Visual',
          inactive = 'TabLine',
        },
      },
    },
  },
})

require('gitsigns').setup({
  current_line_blame = true,
})

require('nvim-surround').setup()

-- Calls lspconfig's vscoqtop.setup() internally; do not configure vscoqtop separately.
require('vsrocq').setup({
  lsp = {
    on_attach = function(_, bufnr)
      vim.keymap.set({ 'n', 'i' }, '<C-M-j>', '<cmd>VsRocq stepForward<CR>', { buffer = bufnr, desc = 'VsRocq step forward' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-k>', '<cmd>VsRocq stepBackward<CR>', { buffer = bufnr, desc = 'VsRocq step backward' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-l>', '<cmd>VsRocq interpretToPoint<CR>', { buffer = bufnr, desc = 'VsRocq interpret to point' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-g>', '<cmd>VsRocq interpretToEnd<CR>', { buffer = bufnr, desc = 'VsRocq interpret to end' })
    end,
  },
})

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
  'https://github.com/Bekaboo/dropbar.nvim',

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

-- Treesitter (nvim-treesitter `main` branch: parsers are installed explicitly and
-- highlighting/folding are enabled through Neovim's built-in vim.treesitter API)
require('nvim-treesitter').install({
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
  'rust',
  'systemtap',
  'systemverilog',
  'tablegen',
  'toml',
  'typescript',
  'vim',
  'yaml'
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserTreesitter', {}),
  callback = function(ev)
    -- pcall: vim.treesitter.start errors if no parser exists for this filetype
    if pcall(vim.treesitter.start, ev.buf) then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})

-- Treesitter textobjects (`main` branch: options via setup, keymaps defined manually)
require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v',
      ['@function.outer'] = 'V',
      ['@class.outer'] = '<c-v>',
    },
    include_surrounding_whitespace = true,
  },
  move = {
    set_jumps = true,
  },
})

local ts_select = require('nvim-treesitter-textobjects.select')
local ts_swap = require('nvim-treesitter-textobjects.swap')
local ts_move = require('nvim-treesitter-textobjects.move')

local function map_select(lhs, query, group, desc)
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    ts_select.select_textobject(query, group or 'textobjects')
  end, { desc = desc })
end

map_select('af', '@function.outer')
map_select('if', '@function.inner')
map_select('ac', '@class.outer')
map_select('ic', '@class.inner', nil, 'Select inner part of a class region')
map_select('as', '@local.scope', 'locals', 'Select language scope')

vim.keymap.set('n', '<leader>a', function() ts_swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>A', function() ts_swap.swap_previous('@parameter.inner') end)

local function map_move(lhs, fn, query, group, desc)
  vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
    ts_move[fn](query, group or 'textobjects')
  end, { desc = desc })
end

map_move(']m', 'goto_next_start', '@function.outer')
map_move(']]', 'goto_next_start', '@class.outer', nil, 'Next class start')
map_move(']o', 'goto_next_start', { '@loop.inner', '@loop.outer' })
map_move(']s', 'goto_next_start', '@local.scope', 'locals', 'Next scope')
map_move(']z', 'goto_next_start', '@fold', 'folds', 'Next fold')

map_move(']M', 'goto_next_end', '@function.outer')
map_move('][', 'goto_next_end', '@class.outer')

map_move('[m', 'goto_previous_start', '@function.outer')
map_move('[[', 'goto_previous_start', '@class.outer')

map_move('[M', 'goto_previous_end', '@function.outer')
map_move('[]', 'goto_previous_end', '@class.outer')

map_move(']d', 'goto_next', '@conditional.outer')
map_move('[d', 'goto_previous', '@conditional.outer')

require('trouble').setup()

require('fzf-lua').setup({
  actions = {
    files = {
      -- overrides fzf-lua's default ctrl-t (open in tab) to send results to Trouble instead
      ["ctrl-t"] = require("trouble.sources.fzf").actions.open,
    },
  },
})

require('snacks').setup({
  explorer = {},
  zen = {},
  image = { enabled = true },
})

-- Winbar breadcrumbs (path + LSP/treesitter symbols). Lualine is left to the
-- statusline and tabline so the two don't fight over the winbar.
require('dropbar').setup()

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

require('vsrocq').setup({
  vsrocq = {
    proof = {
      mode = "Continuous"
    }
  },
  lsp = {
    on_attach = function(_, bufnr)
      vim.keymap.set({ 'n', 'i' }, '<C-M-j>', '<cmd>VsRocq stepForward<CR>', { buffer = bufnr, desc = 'VsRocq step forward' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-k>', '<cmd>VsRocq stepBackward<CR>', { buffer = bufnr, desc = 'VsRocq step backward' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-l>', '<cmd>VsRocq interpretToPoint<CR>', { buffer = bufnr, desc = 'VsRocq interpret to point' })
      vim.keymap.set({ 'n', 'i' }, '<C-M-g>', '<cmd>VsRocq interpretToEnd<CR>', { buffer = bufnr, desc = 'VsRocq interpret to end' })
    end,
  },
})

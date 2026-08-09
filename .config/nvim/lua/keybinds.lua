local fzf_lua = require('fzf-lua')

local keymap = vim.keymap.set

-- K (hover), grn (rename), gra (code action), grr/gri/grt (references/impl/type-def),
-- gO (document symbols), and i_CTRL-S (signature help) are native Neovim LSP defaults
-- (see :h lsp-defaults) and need no keymap here. 'omnifunc' is likewise set automatically.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- jump to definition
    keymap('n', 'gd', vim.lsp.buf.definition, opts)

    -- Format buffer
    keymap('n', '<F3>', vim.lsp.buf.format, opts)

    -- Jump LSP diagnostics
    keymap('n', '[g', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    keymap('n', ']g', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)

    -- Rename symbol
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Find references (combined refs/def/impl view)
    keymap('n', 'gr', fzf_lua.lsp_finder, opts)

    -- codeaction
    keymap('n', '<leader>ac', vim.lsp.buf.code_action, opts)
    keymap('v', '<leader>a', vim.lsp.buf.code_action, opts)
  end,
})

-- Floating terminal (not LSP-specific, so bound globally rather than on LspAttach)
keymap({ 'n', 't' }, '<A-d>', function() Snacks.terminal() end, { silent = true })

keymap('n', '<leader>ff', fzf_lua.files, {})
keymap('n', '<leader>fg', fzf_lua.live_grep, {})
keymap('n', '<leader>fb', fzf_lua.buffers, {})
keymap('n', '<leader>fh', fzf_lua.help_tags, {})

keymap('n', '<leader>e', function() Snacks.explorer() end, {})
Snacks.toggle.zen():map('<leader>z')

keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {silent = true, noremap = true})
keymap("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", {silent = true, noremap = true})
keymap("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",{silent = true, noremap = true})
keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",{silent = true, noremap = true})
keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",{silent = true, noremap = true})
keymap("n", "gR", "<cmd>Trouble lsp_references toggle<cr>",{silent = true, noremap = true})

fzf_lua.setup {
  actions = {
    files = {
      -- overrides fzf-lua's default ctrl-t (open in tab) to send results to Trouble instead
      ["ctrl-t"] = require("trouble.sources.fzf").actions.open,
    },
  },
}

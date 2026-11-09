local fzf_lua = require('fzf-lua')

local keymap = vim.keymap.set

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
    keymap('n', 'gR', fzf_lua.lsp_finder, opts)

    -- codeaction
    keymap('v', '<leader>a', vim.lsp.buf.code_action, opts)
  end,
})

-- Floating terminal
keymap({ 'n', 't' }, '<A-d>', function() Snacks.terminal() end, { silent = true })

keymap('n', '<leader>ff', fzf_lua.files, {})
keymap('n', '<leader>fg', fzf_lua.live_grep, {})
keymap('n', '<leader>fb', fzf_lua.buffers, {})
keymap('n', '<leader>fh', fzf_lua.help_tags, {})

keymap('n', '<leader>e', function() Snacks.explorer() end, {})

vim.keymap.set('n', '<Leader>;', require('dropbar.api').pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', require('dropbar.api').goto_context_start, { desc = 'Go to start of current context' })
vim.keymap.set('n', '];', require('dropbar.api').select_next_context, { desc = 'Select next context' })

keymap('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { silent = true, desc = 'Toggle git blame' })

keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {silent = true, noremap = true})
keymap("n", "<leader>xi", "<cmd>Trouble lsp_implementations toggle<cr>",{silent = true, noremap = true})
keymap("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>",{silent = true, noremap = true})
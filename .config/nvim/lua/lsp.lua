local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup()

lspconfig['asm_lsp'].setup({})
lspconfig['bashls'].setup({})
lspconfig['clangd'].setup({})
lspconfig['cssls'].setup({})
lspconfig['dockerls'].setup({})
lspconfig['gopls'].setup({})
lspconfig['html'].setup({})
lspconfig['jsonls'].setup({})
lspconfig['ltex'].setup({})
lspconfig['lua_ls'].setup({
  settings = {
    telemetry = {
      enable = false,
    }
  },

})
lspconfig['marksman'].setup({})
lspconfig['neocmake'].setup({})
lspconfig['pyright'].setup({})
lspconfig['ruff'].setup({
  on_attach = function (client, buffer)
    client.server_capabilities.hoverProvider = false
  end,
})
lspconfig['rust_analyzer'].setup({})
lspconfig['texlab'].setup({})
lspconfig['ts_ls'].setup({})
lspconfig['verible'].setup({})
lspconfig['yamlls'].setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
  end,
})

local null_ls = require("null-ls")

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'cmake',
    'cssls',
    'dockerls',
    'jsonls',
    'ltex',
    'lua_ls',
    'marksman',
    'pyright',
    'svlangserver',
    'texlab',
    'tsserver',
    'yamlls'
  }
})

require('mason-lspconfig').setup_handlers({
  function (server_name)
    require('lspconfig')[server_name].setup {}
  end
})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.gitsigns
  },
})
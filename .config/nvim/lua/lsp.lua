local lspconfig = require('lspconfig')
local luasnip = require('luasnip')
local cmp = require('cmp')

require('mason').setup()
require('mason-lspconfig').setup()

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig['asm_lsp'].setup({
  capabilities = cmp_capabilities
})
lspconfig['bashls'].setup({
  capabilities = cmp_capabilities
})
lspconfig['clangd'].setup({
  capabilities = cmp_capabilities
})
lspconfig['cssls'].setup({
  capabilities = cmp_capabilities
})
lspconfig['dockerls'].setup({
  capabilities = cmp_capabilities
})
lspconfig['gopls'].setup({
  capabilities = cmp_capabilities
})

lspconfig['html'].setup({
  capabilities = cmp_capabilities
})
lspconfig['jsonls'].setup({
  capabilities = cmp_capabilities
})
lspconfig['ltex'].setup({
  capabilities = cmp_capabilities
})
lspconfig['lua_ls'].setup({
  settings = {
    telemetry = {
      enable = false,
    }
  },
  capabilities = cmp_capabilities
})
lspconfig['marksman'].setup({
  capabilities = cmp_capabilities
})
lspconfig['neocmake'].setup({
  capabilities = cmp_capabilities
})
lspconfig['pyright'].setup({
  capabilities = cmp_capabilities
})
lspconfig['ruff'].setup({
  on_attach = function (client, buffer)
    client.server_capabilities.hoverProvider = false
  end,
})
lspconfig['rust_analyzer'].setup({
  capabilities = cmp_capabilities
})
lspconfig['texlab'].setup({
  capabilities = cmp_capabilities
})
lspconfig['ts_ls'].setup({
  capabilities = cmp_capabilities
})
lspconfig['verible'].setup({
  capabilities = cmp_capabilities
})
lspconfig['yamlls'].setup({
  capabilities = cmp_capabilities
})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require('mason').setup()
require('mason-lspconfig').setup()

local lsps = {
  { 'asm_lsp' },
  { 'bashls' },
  { 'clangd' },
  { 'cssls' },
  { 'dockerls' },
  { 'gopls' },
  { 'html' },
  { 'jsonls' },
  { 'ltex' },
  {
    'lua_ls',
    {
      settings = {
        telemetry = {
          enable = false,
        }
      }
    }
  },
  { 'marksman' },
  { 'neocmake' },
  { 'pyright' },
  {
    'ruff',
    {
      on_attach = function (client, buffer)
        client.server_capabilities.hoverProvider = false
      end,
    }
  },
  { 'rust_analyzer' },
  { 'texlab' },
  { 'ts_ls' },
  { 'verible' },
  { 'yamlls' }
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config then
    vim.lsp.config(name, config)
  end
end


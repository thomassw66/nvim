local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  "sumneko_lua",
  "clangd",
}

lsp_installer.setup({
  -- ensure_installed = servers,
  automatic_installation = true,
})

local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require("user.lsp.settings.sumneko_lua").settings,
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

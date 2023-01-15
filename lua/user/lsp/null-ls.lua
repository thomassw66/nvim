-- local diagnostics = null_ls.builtins.diagnostics

-- Null ls is used to configure the methods of `format, diagnostics, completion, code_actions`
-- which isn't supply by the lsp server.
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- custom swift format stuff.
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
FORMATTING = methods.internal.FORMATTING


null_ls.setup({
  debug = false,
  sources = {
  },
  on_attach = require("user.lsp.handlers").on_attach,
})

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
local format_swift_format = h.make_builtin({
  name = "swift-format",
  method = FORMATTING,
  filetypes = { "swift" },
  generator_opts = {
    command = "swift-format",
    args = { "$FILENAME" },
    to_stdin = true,
  },
  factory = h.formatter_factory,
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#completion
-- local completion = null_ls.builtins.completion
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier,
    formatting.black.with({ extra_args = { "--fast" } }),
    diagnostics.flake8,
    diagnostics.jsonlint,
    formatting.jq,
    code_actions.gitsigns,
    formatting.latexindent,
    diagnostics.chktex,
    --vformat_swift_format,
  },
  on_attach = require("user.lsp.handlers").on_attach,
})

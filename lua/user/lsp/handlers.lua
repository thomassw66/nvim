local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
    {
      border = "rounded",
    })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers
    .signature_help, {
    border = "rounded",
    focusable = true,
    relative = "cursor",
  })

  -- Borders for LspInfo winodw
  local win = require "lspconfig.ui.windows"
  local _default_opts = win.default_opts

  win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
  end

end


local function lsp_highlight_line_number()
  vim.cmd [[
    highlight! DiagnosticLineNrError guibg=transparent guifg=#F37878 gui=bold
    highlight! DiagnosticLineNrWarn guibg=transparent guifg=orange gui=bold
    highlight! DiagnosticLineNrInfo guibg=transparent guifg=#E6FFED gui=bold
    highlight! DiagnosticLineNrHint guibg=transparent guifg=#E6FFED gui=bold
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
  ]]
end

local function lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }

  -- Declaration and definition
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

  -- Docs
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>"
    , opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr",
    "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ca",
    "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>od",
    "<cmd>lua vim.diagnostic.open_float({ border='single'})<CR>",
    opts)

  -- Diagnostic
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d",
    "<cmd>lua vim.diagnostic.goto_prev({ float={ border='single' }})<CR>",
    opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d",
    "<cmd>lua vim.diagnostic.goto_next({ float={ border='single' }})<CR>",
    opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q",
    "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

function Set(list)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)
  lsp_highlight_line_number()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("failed to load cmp_nvim_lsp")
  return
end

local cmp_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

cmp_capabilities.textDocument.semanticHighlighting = true
cmp_capabilities.offsetEncoding = "utf-8"
cmp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = cmp_capabilities

return M

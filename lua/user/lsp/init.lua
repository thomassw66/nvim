local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("failed to load lspconfig")
	return
end

nvim_lsp.sourcekit.setup({})
nvim_lsp.bashls.setup({})

require("user.lsp.lsp-installer")

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then
	vim.notify("failed to load handlers module!")
	return
end

handlers.setup()

require("user.lsp.null-ls")

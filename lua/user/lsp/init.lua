
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then 
	vim.notify("failed to load lspconfig")
	return
end 


require("user.lsp.lsp-installer")

require'lspconfig'.clangd.setup{}

--local servers = { "clangd" }
--for _, lsp in pairs(servers) do
--	require('lspconfig')[lsp].setup {
--		on_attach = 
--	}
--end

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then 
	vim.notify("failed to load handlers module!")
	return 
end

handlers.setup()


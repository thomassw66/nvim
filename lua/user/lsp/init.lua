
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then 
	vim.notify("failed to load lspconfig")
	return
end 


require("user.lsp.lsp-installer")

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then 
	vim.notify("failed to load handlers module!")
	return 
end

handlers.setup()

local configs = require('lspconfig.configs')
configs.cider_lsp = {
	default_config = {
		cmd = { '/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp', '--noforward_sync_responses' };
		filetypes = { 'c', 'cpp', 'java', 'proto', 'textproto', 'go', 'python', 'bzl' };
		root_dir = nvim_lsp.util.root_pattern('BUILD');
		settings = {};
	},
}


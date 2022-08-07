local lspconfig = require("lspconfig")

return {
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
	root_dir = root_pattern("Package.swift", ".git"),
}

local lspconfig = require("lspconfig")

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gotmpl" },
	root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
	single_file_support = true,
}

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.swiftformat, -- swift
		formatting.clang_format, -- c++ / objectivec / ...
		formatting.stylua, -- lua
		formatting.gofmt, -- golang
		-- python
		-- javascript / typescript
		-- html css
	},
})

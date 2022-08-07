local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local h = require("null-ls.helpers")

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

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

null_ls.setup({
	debug = false,
	sources = {
		formatting.clang_format, -- c++ / objectivec / ...
		formatting.stylua, -- lua
		formatting.gofmt, -- golang
		-- formatting.swiftformat, --swift
		format_swift_format,
		formatting.yapf, --python
		-- javascript / typescript
		-- html css
		formatting.beautysh, -- bash
	},
})


local configs = require("nvim-treesitter.configs")
configs.setup {
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "all",

	-- Install languages synchronously.
	sync_install = false,

	-- List of parsers to ignore installing.
	ignore_install = { 
		-- Mysteriously fails to install, I don't use any norg atm so ignore for now.
		"norg"
	},

	highlight = {

		-- false will disable the whole extension.
		enable = true,

		--- list of languages that will be disabled.
		disable = { "" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to true if you depend of syntax being enabled (e.g. for indentation).
		-- Using this option may slow you editor, and you may see duplicate highlights.
		-- Instead of true this can also be a list of languages.
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
}

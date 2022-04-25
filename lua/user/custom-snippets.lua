-- local luasnip = require("luasnip")

--local t = luasnip.t
--local s = luasnip.s
--local i = luasnip.i

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./custom-snippets" } })

--luasnip.add_snippets("all", {
--	s("segment_tree", {
--		t("struct segment_tree {"),
--		t("};"),
--	}),
--	}),
--})

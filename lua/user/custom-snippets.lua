
local luasnip = require"luasnip"

local s = luasnip.s
local i = luasnip.i
local t = luasnip.t

-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

luasnip.add_snippets("all", {
	s("union_find", {
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),
})




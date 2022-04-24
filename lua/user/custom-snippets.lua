
local luasnip = require"luasnip"

local s = luasnip.s
local i = luasnip.i
local t = luasnip.t

luasnip.add_snippets("all", {
	s("union_find", {
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),
})




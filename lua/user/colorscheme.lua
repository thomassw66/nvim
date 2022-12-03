-- vim.cmd "colorscheme system76"
-- vim.cmd "colorscheme auorora"
-- vim.cmd "colorscheme tokyonight"
-- vim.cmd "colorscheme darkplus"
-- vim.vmd "colorscheme onedarker"

-- local colorscheme = "tokyonight"
-- local colorscheme = "nord"
local colorscheme = "onenord"
-- local colorscheme = "poimandres"
-- local colorscheme = "carbonized-light"
-- local colorscheme = "hybrid_material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

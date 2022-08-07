local options = {
	backup = false, -- creates backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages.
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files.
	fileencoding = "utf-8", -- the encoding written to a file.
	hlsearch = true, -- highligh all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allows the mouse to be used.
	pumheight = 10, -- the popup menu height.
	showmode = true, -- whether to show the current command mode, true for now.
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case: if we search for a patter with uppercase letters and ignore case is on, the search will be case sensitive.
	smartindent = false, -- smart indenting for C like programs.
	splitbelow = true, -- force all horizontal :split`s to go below the current window.
	splitright = true, -- force all vertical :vsplit`s to go to the right of the current window.
	swapfile = false, -- creates a swapfile
	timeoutlen = 1000, -- time to wait for a mapoped sequence to complete (milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)

	termguicolors = true,

	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = false,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,

	scrolloff = 8,
	sidescrolloff = 8,
	-- guifont = "SoureCodePro+Powerline+Awesome",
	guifont = "monospace:h17",
}

vim.opt.shortmess:append("c")
for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " tabs are space
]])

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])

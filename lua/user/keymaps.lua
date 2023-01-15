local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope  --
keymap("n", "<leader>tf", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>tl", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>f", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
keymap("n", "<leader>m", ":messages<CR>", opts)

keymap("n", "<leader>cp", ":call TwCpInit()<CR>", opts)
keymap("n", "<leader>un", ":call TwUnixTemplateInit()<CR>", opts)

-- vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = { "*.lua" },
--  callback = function()
--    vim.lsp.buf.format({ async = false })
--  end,
-- })

vim.api.nvim_exec(
  [[
let g:tw_cp_tmpl_path = glob('~/.config/nvim/templates/cp')
let g:tw_unix_template_path = glob('~/.config/nvim/templates/templates/tlpi')

function! TwCopyFile(f_name, template_path)
	let tmpl_file = a:template_path . '/' . a:f_name
	let f_bytes = readfile(tmpl_file, "b")
	call writefile(f_bytes, a:f_name, "b")
endfunction

function! TwCpInit()
	call TwCopyFile('makefile', g:tw_cp_tmpl_path)
	call TwCopyFile('.gitignore', g:tw_cp_tmpl_path)
  call TwCopyFile('s.sh', g:tw_cp_tmpl_path)

	let main_file = g:tw_cp_tmpl_path . '/' . 'main.cc'
	exec "r !cat ". main_file
endfunction 

function! TwUnixTemplateInit()
  call TwCopyFile("makefile", g:tw_unix_template_path)
  call TwCopyFile("unix_helpers.cc", g:tw_unix_template_path)
  call TwCopyFile("unix_helpers.h", g:tw_unix_template_path)

  " call TwCopyFile("tmpl.cc", g:tw_unix_template_path)

	let main_file = g:tw_unix_template_path . '/' . 'tmpl.cc'
	exec "r !cat ". main_file
endfunction 

function! EchoStrategy(cmd)
	echo 'It works! Command for running tests: ' . a:cmd
endfunction
]] ,
  false
)

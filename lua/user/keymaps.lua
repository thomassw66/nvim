local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
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

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope  --
keymap("n", "<leader>tf", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>tl", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>f", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
keymap("n", "<leader>y", ":Yapf<CR>", opts)
keymap("n", "<leader>m", ":messages<CR>", opts)

keymap("n", "<leader>hm", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/custom-snippets.lua<CR>", opts)

keymap("n", "<leader>cp", ":call TwCpInit()<CR>", opts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "text", "*" },
	callback = function()
		local data = {
			buf = vim.fn.expand("<abuf>"),
			file = vim.fn.expand("<afile>"),
			match = vim.fn.expand("<amatch>"),
		}

		vim.schedule(function()
			print("Hej, we got called")
			print(vim.inspect(data))
		end)
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	callback = function()
		vim.api.nvim_command("EslintFixAll")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua" },
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

vim.api.nvim_exec(
	[[
let g:tw_cp_tmpl_path = glob('~/.config/nvim/cp-tmpl')

function! TwCopyFile(f_name)
	let tmpl_file = g:tw_cp_tmpl_path . '/' . a:f_name
	let f_bytes = readfile(tmpl_file, "b")
	call writefile(f_bytes, a:f_name, "b")
endfunction

function! TwCpInit()
	call TwCopyFile('makefile')
	call TwCopyFile('.gitignore')
  call TwCopyFile('gen.py')
  call TwCopyFile('s.sh')
  call TwCopyFile('main.py')

	let main_file = g:tw_cp_tmpl_path . '/' . 'main.cc'
	exec "r !cat ". main_file
endfunction 

function! EchoStrategy(cmd)
	echo 'It works! Command for running tests: ' . a:cmd
endfunction
]],
	false
)

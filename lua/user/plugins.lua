local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("installing packer close and reopen neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end 
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- my plugins here.
	use("wbthomason/packer.nvim") -- packer manages itself.
	use("nvim-lua/popup.nvim") -- vim popup api in neovim
	use("nvim-lua/plenary.nvim") -- useful lua functions.
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitterk

	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	use("lunarvim/colorschemes") -- a bunch of colorschemes
	use("folke/tokyonight.nvim")
	use("arcticicestudio/nord-vim")
	use("haystackandroid/carbonized")
	use("kristijanhusak/vim-hybrid-material")

	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("moll/vim-bbye")
	use("akinsho/bufferline.nvim")

	-- toggle term
	use("akinsho/toggleterm.nvim")

	-- cmp plugings
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions.
	use("hrsh7th/cmp-cmdline") -- cmdline completions.
	use("saadparwaiz1/cmp_luasnip") -- snippet completions.
	use("hrsh7th/cmp-nvim-lua") -- cmdline completions.
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- bunch of snippets

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")

	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	use("google/maktaba")
	use("bazelbuild/vim-bazel")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

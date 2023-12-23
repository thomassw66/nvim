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

-- Auto run packer sync when this file is saved.
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
  use("wbthomason/packer.nvim")
  use("nvim-lua/popup.nvim") -- vim popup api in neovim
  use("nvim-lua/plenary.nvim") -- useful lua functions.

  -- Autopairs, integrates with both cmp and treesitterk
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  -- use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

  -- a bunch of colorschemes
  use("lunarvim/colorschemes")
  use("arcticicestudio/nord-vim")
  use("kristijanhusak/vim-hybrid-material")

  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("moll/vim-bbye")
  use("akinsho/bufferline.nvim")

  use("nvim-lualine/lualine.nvim")

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

  use({ "nvim-telescope/telescope-ui-select.nvim" })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/playground")


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

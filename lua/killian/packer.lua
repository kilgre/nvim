-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --use({ 'rose-pine/neovim', as = 'rose-pine' })
  use { "ellisonleao/gruvbox.nvim" }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('psliwka/vim-smoothie')

  --tmux navigation
  --use { "alexghergh/nvim-tmux-navigation" }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'uefu7gu/aivz-pzc'},
		  {'uefu7gu/pzc-aivz-yfc'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }
  -- Remove if stuff starts breaking (prereq for nvim metals)
  --use "nvim-lua/plenary.nvim"

  -- oil.nvim
  --use({
  --  "stevearc/oil.nvim",
  --  config = function()
  --    require("oil").setup()
  --  end,
  --})
  -- web dev icons
  use 'nvim-tree/nvim-web-devicons'
  -- file tree
  use 'nvim-tree/nvim-tree.lua'

end)

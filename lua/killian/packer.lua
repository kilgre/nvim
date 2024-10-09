-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use('nvim-lua/plenary.nvim')

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --use({ 'rose-pine/neovim', as = 'rose-pine' })
  use { "ellisonleao/gruvbox.nvim" }

  --use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  --use('nvim-treesitter/playground')
  use { 
      'theprimeagen/harpoon',
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('psliwka/vim-smoothie')

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
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }
  -- file tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }
  -- metals stuff (???)
  use({
      "scalameta/nvim-metals",
      requires = {
          "nvim-lua/plenary.nvim",
          "mfussenegger/nvim-dap",
      },
  })
  -- tmux navigation
  use({
      "christoomey/vim-tmux-navigator",
  })
  -- which key
  use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section
        }
      end
    }

  -- lua line
  use 'nvim-lualine/lualine.nvim'

  -- nvim-surround 
  -- TODO: troubleshoot
  use({
    "kylechui/nvim-surround",
    tag = "main", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })

  -- codewhisperer
  -- TODO
  
  -- markdown previewer
  -- TODO: fix on dev desk
  --    works by using `open` or `xdg-open` commands, which is fine
  --    on mac but AL2 dev desk doesn't have either. downloaded xdg-utils
  --    source but couldn't make it correctly
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- formatter
    use { 'mhartington/formatter.nvim' }
end)

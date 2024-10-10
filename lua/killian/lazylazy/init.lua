return {
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
              dependencies = { 'nvim-lua/plenary.nvim' }
        },
      {
          "rose-pine/neovim",
          name = "rose-pine",
          config = function()
              vim.cmd("colorscheme rose-pine")
          end

      },
      --use { "ellisonleao/gruvbox.nvim" }

      -- trouble
      {
          "folke/trouble.nvim",
          opts = {}, -- for default options, refer to the configuration section for custom setup.
          cmd = "Trouble",
          keys = {
            {
              "<leader>xx",
              "<cmd>Trouble diagnostics toggle<cr>",
              desc = "Diagnostics (Trouble)",
            },
            {
              "<leader>xX",
              "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              desc = "Buffer Diagnostics (Trouble)",
            },
            {
              "<leader>cs",
              "<cmd>Trouble symbols toggle focus=false<cr>",
              desc = "Symbols (Trouble)",
            },
            {
              "<leader>cl",
              "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
              "<leader>xL",
              "<cmd>Trouble loclist toggle<cr>",
              desc = "Location List (Trouble)",
            },
            {
              "<leader>xQ",
              "<cmd>Trouble qflist toggle<cr>",
              desc = "Quickfix List (Trouble)",
            },
          },
        },

      {
          "nvim-treesitter/nvim-treesitter",
          name = "treesitter",
          build = ":TSUpdate",
      },
      {
          "tpope/vim-fugitive",
          name = "fugitive"
      },
      {
          "psliwka/vim-smoothie",
          name = "vim-smoothie"
      },

--      use {
--          'VonHeikemen/lsp-zero.nvim',
--          branch = 'v3.x',
--          requires = {
--              --- Uncomment these if you want to manage the language servers from neovim
--              {'williamboman/mason.nvim'},
--              {'williamboman/mason-lspconfig.nvim'},
--
--              -- LSP Support
--              {'neovim/nvim-lspconfig'},
--
--              -- Autocompletion
--              {'hrsh7th/nvim-cmp'},
--              {'hrsh7th/cmp-nvim-lsp'},
--              {'L3MON4D3/LuaSnip'},
--          }
--      }
      -- file tree
--      use {
--        'nvim-tree/nvim-tree.lua',
--        requires = {
--          'nvim-tree/nvim-web-devicons', -- optional
--        },
--      }
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
      -- tmux navigation
--      use({
--          "christoomey/vim-tmux-navigator",
--      })
      -- which key
--      use {
--          "folke/which-key.nvim",
--          config = function()
--            vim.o.timeout = true
--            vim.o.timeoutlen = 300
--            require("which-key").setup {
--              -- your configuration comes here
--              -- or leave it empty to use the default settings
--              -- refer to the configuration section
--            }
--          end
--        }

      -- lua line
--      use 'nvim-lualine/lualine.nvim'

        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = {
                function()
                    require('lualine').setup {
                        sections = {
                            lualine_x = {'fileformat', 'filetype'},
                        },
                        options = {
                            theme = 'gruvbox', -- Or set a specific theme
                        }
                    }
                end
            }
        },

      -- lsp stuff
      {
          "williamboman/mason.nvim",
          name = "mason",
          config =
            function()
                require("mason").setup()
            end
      },
      {
          "neovim/nvim-lspconfig",
          name = "lspconfig",
          dependencies = { "mason-lspconfig" },
          config =
              function()
                  local on_att =
                      function(_, _)
                          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
                      end
                  require("lspconfig").lua_ls.setup({
                      on_attach = on_att
                  })
                  -- setup mason auto install
                  -- No clue how to fix this
--                local mason_lspconfig = require("mason-lspconfig")
--                -- auto handlers
--                mason_lspconfig.setup_handlers({
--                    -- The first entry (without a key) will be the default handler
--                    -- and will be called for each installed server that doesn't have
--                    -- a dedicated handler.
--                    function (server_name) -- default handler (optional)
--                        require("lspconfig")[server_name].setup {}
--                    end,
--                    -- Next, you can provide a dedicated handler for specific servers.
--                    -- For example, a handler override for the `rust_analyzer`:
--                    ["rust_analyzer"] = function ()
--                        require("rust-tools").setup {}
--                    end
--                })
              end
      },
      -- completions stuff
      {
          "hrsh7th/nvim-cmp",
      },
      {
          "hrsh7th/cmp-nvim-lsp",
      },
      -- nvim-surround 
      -- TODO: troubleshoot
--      use({
--        "kylechui/nvim-surround",
--        tag = "main", -- Use for stability; omit to use `main` branch for the latest features
--        config = function()
--            require("nvim-surround").setup({
--                -- Configuration here, or leave empty to use defaults
--            })
--        end
--      })
--
--      -- codewhisperer
--      -- TODO
--      
--      -- markdown previewer
--      -- TODO: fix on dev desk
--      --    works by using `open` or `xdg-open` commands, which is fine
--      --    on mac but AL2 dev desk doesn't have either. downloaded xdg-utils
--      --    source but couldn't make it correctly
--        use({
--            "iamcco/markdown-preview.nvim",
--            run = function() vim.fn["mkdp#util#install"]() end,
--        })
--
--        -- formatter
--        use { 'mhartington/formatter.nvim' }

--  spec = {
--    -- import your plugins
--    { import = "plugins" },
--  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

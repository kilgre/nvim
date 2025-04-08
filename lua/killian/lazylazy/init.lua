return {
-- work only
-- commenting out for now, requires nvim >= 0.10.4
  --{
  --  name = 'amazonq',
  --  url = 'ssh://git.amazon.com/pkg/AmazonQNVim',
  --  opts = {
  --    ssoStartUrl = 'https://amzn.awsapps.com/start',
  --    -- Note: It's normally not necessary to change default `lsp_server_cmd`.
  --    -- lsp_server_cmd = {
  --    --   'node',
  --    --   vim.fn.stdpath('data') .. '/lazy/AmazonQNVim/language-server/build/aws-lsp-codewhisperer-token-binary.js',
  --    --   '--stdio',
  --    -- },
  --  },
  --  config = function ()
  --      require('amazonq').setup({
  --        -- Command passed to `vim.lsp` to start Q LSP. Amazon -- Q LSP is
  --        -- a NodeJS program, which must be started with `--stdio` flag.
  --        --lsp_server_cmd = { 'node', 'path/to/aws-lsp-codewhisperer-token-binary.js', '--stdio' },
  --        -- IAM Identity Center portal for organisation.
  --        ssoStartUrl = 'https://view.awsapps.com/start',
  --        --inline_suggest = true,
  --        ---- List of filetypes where the Q will be activated.
  --        ---- Docs: https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-language-ide-support.html
  --        ---- Note: These must be valid Nvim filetypes. For example, Q supports "shell",
  --        ---- but in the filetype name is "sh" (also "bash").
  --        --filetypes = {
  --        --    'amazonq', 'bash', 'java', 'python', 'typescript', 'javascript', 'csharp', 'ruby', 'kotlin', 'sh', 'sql', 'c',
  --        --    'cpp', 'go', 'rust', 'lua',
  --        --},
  --        ---- Window split direction. Default is "vertical", also accepts "horizontal".
  --        --window_direction = 'vertical',
  --        ---- Window width when window_direction=vertical, or height when window_direction=horizontal.
  --        --window_size = '80',
  --        ---- Enable debug mode (for development).
  --        debug = false,
  --      })
  --      end
  --    },
        -- THEMES
      {
        "rebelot/kanagawa.nvim",
        name = "kangawa",
      },
      {
        "rose-pine/neovim",
        name = "rose-pine",
      },
      {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd("colorscheme tokyonight-moon")
        end
      },
      {
        "loctvl842/monokai-pro.nvim",
        config = function()
          --require("monokai-pro").setup()
          --vim.cmd("colorscheme monokai-pro")
        end
      },
      {
          "ellisonleao/gruvbox.nvim",
          name = "gruvbox",
          priority = 1000,
          config = function()
              require("gruvbox").setup({
                transparent_mode = true,
                --overrides = {
                --    SignColumn = {bg = "#282828"}
                --}
            })
            --vim.cmd("colorscheme gruvbox")
          end
      },
    --------------------------------------------------
    --<Start packages that break the welcome screen>--
      -- nvim doing
      {
          "Hashino/doing.nvim",
          config = true,
      },
    -- nvim marks (better marks)
  -- https://github.com/chentoast/marks.nvim
      {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
      },
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true;
                vim.o.timeoutlen = 300;
                require("which-key").setup {
                }
            end
        },
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
                            --theme = 'tokynight', -- Or set a specific theme
                            theme = 'monokai-pro',
                        },
                        winbar = {
                            lualine_a = { require"doing.api".status },
                        }
                    }
                end
            }
        },
    --<End packages that break welcome screen>--
    --------------------------------------------------


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
    -- /trouble
      {
          "nvim-treesitter/nvim-treesitter",
          name = "treesitter",
          build = ":TSUpdate",
      },
      {
          "tpope/vim-fugitive",
          name = "fugitive"
      },
--      -- git signs
      {
          "lewis6991/gitsigns.nvim",
          name = "gitsigns",
          config = function()
            require("gitsigns").setup()
          end
      },
      {
          "psliwka/vim-smoothie",
          name = "vim-smoothie"
      },
      -- tmux navigation
      {
          "christoomey/vim-tmux-navigator",
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
    -- tools
    {
        'norcalli/nvim-colorizer.lua',
        name = "colorizer",
        config = function()
            require("colorizer").setup {
            }
        end
        -- test #fe45a2
    },
    -- /tools
    -- fun plugins
    {
        'eandrju/cellular-automaton.nvim',
    },
    -- /fun plugins
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

  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

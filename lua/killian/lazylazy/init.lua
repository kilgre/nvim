return {
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
            --vim.cmd("colorscheme tokyonight-moon")
        end
    },
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("monokai-pro").setup()
            vim.cmd("colorscheme monokai-pro")
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
    --Actually i think i fixed it removing lsp section 
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
    -- git signs
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

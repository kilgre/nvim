-- ~/.config/nvim/lua/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        "mfussenegger/nvim-jdtls",
        "hrsh7th/cmp-nvim-lsp",
        {
            url = "kilgre@git.amazon.com:pkg/NinjaHooks",
            branch = "mainline",
            lazy = false,
            config = function(plugin)
                vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
            end,
        },
        { 'j-hui/fidget.nvim', opts = {} },
    },

    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local configs = require("lspconfig.configs")

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()

        local server_configs = {
            -- place language server names and their configuration here as a key-value pair
            ts_ls = {}
        }

        mason.setup()

        -- barium
        vim.filetype.add({
            filename = {
                ['Config'] = function()
                    vim.b.brazil_package_Config = 1
                    return 'brazil-config'
                end,
            },
        })
        configs.barium = {
            default_config = {
                cmd = {'barium'};
                filetypes = {'brazil-config'};
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end;
                settings = {};
            };
        }
        lspconfig.barium.setup({})

        local mason_ensure_installed = vim.tbl_keys(server_configs or {})
        vim.list_extend(
            mason_ensure_installed,
            {
                -- place other packages you want to install but not configure with mason here
                -- e.g. language servers not configured with nvim-lspconfig, linters, formatters, etc.
                "jdtls",
            }
        )
        mason_tool_installer.setup({
            ensure_installed = mason_ensure_installed
        })

        mason_lspconfig.setup({
            handlers = {
                function(server_name)
                    local server_config = server_configs[server_name] or {}
                    server_config.capabilities = vim.tbl_deep_extend(
                        "force",
                        default_capabilities,
                        server_config.capabilities or {}
                    )
                    lspconfig[server_name].setup(server_config)
                end,
                ['jdtls'] = function() end
            },
        })

        -- completions
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        default_capabilities = vim.tbl_deep_extend(
            "force",
            default_capabilities,
            cmp_nvim_lsp.default_capabilities()
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
            callback = function(e)
                local keymap = function(keys, func)
                    vim.keymap.set("n", keys, func, { buffer = e.buf })
                end
                local builtin = require("telescope.builtin")

                keymap("gd", builtin.lsp_definitions)
                --Binds gd to jump to the definition of the symbol under the cursor using the LSP (Language Server Protocol).
                keymap("gD", vim.lsp.buf.declaration)
                --Binds gD to jump to the declaration of the symbol under the cursor using the LSP.
                keymap("gr", builtin.lsp_references)
                --Binds gr to show all references to the symbol under the cursor using the LSP.
                keymap("gI", builtin.lsp_implementations)
                --Binds gI to show the implementations of the symbol under the cursor (e.g., where interfaces or abstract methods are implemented).
                keymap("<leader>D", builtin.lsp_type_definitions)
                --Binds <leader>D to jump to the type definition of the symbol under the cursor using the LSP.
                keymap("<leader>ds", builtin.lsp_document_symbols)
                --Binds <leader>ds to show all symbols in the current document (functions, classes, etc.) using the LSP.
                keymap("<leader>ws", builtin.lsp_dynamic_workspace_symbols)
                --Binds <leader>ws to search and show symbols across the entire workspace (project) dynamically using the LSP.
                keymap("<leader>rn", vim.lsp.buf.rename)
                --Binds <leader>rn to rename the symbol under the cursor using the LSP.
                keymap("<leader>ca", vim.lsp.buf.code_action)
                --Binds <leader>ca to trigger code actions at the cursor's location (e.g., auto-fix, refactoring) using the LSP.
                keymap("K", vim.lsp.buf.hover)
                --Binds K to show hover information about the symbol under the cursor (e.g., documentation) using the LSP.
            end
        })
    end
}

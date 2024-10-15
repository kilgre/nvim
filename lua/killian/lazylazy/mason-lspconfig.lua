return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason" },
    name = "mason-lspconfig",
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = { "lua_ls" }
        })
        end
}

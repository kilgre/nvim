local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- here you can setup the language servers
-- using nvim-metals instead
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#metals
require'lspconfig'.metals.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pylsp.setup{}

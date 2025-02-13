return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    name = "nvim-tree",
    config = function()
        local treeutils = require("killian/scripts/treeutils")
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- OR setup with some options
        require("nvim-tree").setup({
          sort = {
            sorter = "case_sensitive",
          },
          view = {
            side = 'right',
            width = 70,
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = false,
          },
          update_focused_file = { enable = true },
          actions = {
            open_file = {
              quit_on_open = true,
            },
          },
        })

        -- shortcut to focus and unfocus file tree
        vim.keymap.set("n", "<leader>fd", vim.cmd.NvimTreeFocus)
    end
}

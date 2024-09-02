local treeutils = require("killian/treeutils")
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
    dotfiles = true,
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
-- shortcut to toggle the file tree
vim.keymap.set("n", "<leader>ft", vim.cmd.NvimTreeToggle)

-- enable functions in treeutils.lua
vim.keymap.set('n', '<leader>tf', treeutils.launch_find_files)
vim.keymap.set('n', '<leader>ts', treeutils.launch_live_grep)

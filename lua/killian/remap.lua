vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fd", vim.cmd.Ex)

--vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move as group
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- search and stay in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste fix
vim.keymap.set("x", "<leader>p", [["_dP]])

-- paste fixes
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--write with leader
--vim.keymap.set("n", "<leader>w", function()
--    vim.cmd("w")
--end)

--leader s to search and replace all instances of word cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

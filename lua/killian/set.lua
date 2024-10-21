vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

--vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- smart case for searching-- toggling to off becuase it messes with replace
--vim.opt.ignorecase = true
--vim.opt.smartcase = true

--vim.opt.colorcolumn = "80"

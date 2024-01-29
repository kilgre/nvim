vim.o.background = "dark" -- or "light" for light mode

require("gruvbox").setup({
    terminal_colors = true,
    italic = {
        comments = false,
    },
    transparent_mode = false,
})

vim.cmd([[colorscheme gruvbox]])

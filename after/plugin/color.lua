vim.o.background = "dark" -- or "light" for light mode

require("gruvbox").setup({
    terminal_colors = true,
    italic = {
        comments = false,
        strings = false,
    },
    transparent_mode = false,
    contrast = "hard",
})

vim.cmd([[colorscheme gruvbox]])

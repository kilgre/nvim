return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config =
        function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find file" })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Find in git files" })
            vim.keymap.set('n', '<leader>fs', function()
            	builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end, { desc = "Find string" })
        end
}

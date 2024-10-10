return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    name = "harpoon",
    config = 
        function()
            local harpoon = require("harpoon")
            local vim = vim

            harpoon:setup()

            vim.keymap.set(
                "n",
                "<leader>li", 
                function() 
                    local current_file = vim.fn.expand("%:t")
                    harpoon:list():add() 
                    -- not working because list is nil for some reason. Using without index message for now
                    -- I believe some logic could be added to get the index of the file added and print using this function:
                    -- https://github.com/ThePrimeagen/harpoon/blob/harpoon2/lua/harpoon/list.lua#L33
                    --local index = #harpoon:list().entries
                    local message = string.format("'%s' added to Harpoon!", current_file)
                    vim.api.nvim_echo({{message, "None"}}, false, {})
                end,
                { desc = "Add new file to harpoon's list" }
            )
            vim.keymap.set("n", "<leader>lq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[Q]uit harpoon" })

            vim.keymap.set("n", "<leader>la", function() harpoon:list():select(1) end, { desc = "Open harpoon window 1" })
            vim.keymap.set("n", "<leader>ls", function() harpoon:list():select(2) end, { desc = "Open harpoon window 2" })
            vim.keymap.set("n", "<leader>ld", function() harpoon:list():select(3) end, { desc = "Open harpoon window 3" })
            vim.keymap.set("n", "<leader>lf", function() harpoon:list():select(4) end, { desc = "Open harpoon window 4" })

            -- basic telescope configuration
            --local conf = require("telescope.config").values
            --local function toggle_telescope(harpoon_files)
            --    local file_paths = {}
            --    for _, item in ipairs(harpoon_files.items) do
            --        table.insert(file_paths, item.value)
            --    end
            --
            --    require("telescope.pickers").new({}, {
            --        prompt_title = "harpoon",
            --        finder = require("telescope.finders").new_table({
            --            results = file_paths,
            --        }),
            --        previewer = conf.file_previewer({}),
            --        sorter = conf.generic_sorter({}),
            --    }):find()
            --end
            --
            --vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon [l]isting" })
            vim.keymap.set("n", "<leader>ll", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[L]ist harpooned files" })
                    end
}

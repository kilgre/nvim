local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>hn", function() harpoon:list():add() end, { desc = "Add [n]ew file to harpoon" })
vim.keymap.set("n", "<leader>hq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[Q]uit harpoon" })

vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end, { desc = "Open harpoon window 1" })
vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end, { desc = "Open harpoon window 2" })
vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end, { desc = "Open harpoon window 3" })
vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end, { desc = "Open harpoon window 4" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon [l]isting" })

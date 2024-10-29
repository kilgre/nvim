vim.g.mapleader = " "

--vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move as group
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- search and stay in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste fix
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- yank fixes
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank ???" })

--write with leader
vim.keymap.set("n", "<leader>w", function()
    vim.cmd("w")
end, { desc = "Save file" })

--leader s to search and replace all instances of word cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- open current file in codebrowser
local function open_in_code_browser()
    -- Define the base URL for the code browser
    local base_url = "https://code.amazon.com/packages/"

    -- Get the current file’s full path
    local file_path = vim.fn.expand("%:p")

    -- Extract the project root as PACKAGE_NAME
    local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") 

    -- Strip the project directory from the file path for the relative part
    local relative_path = file_path:gsub(".*/" .. project_root .. "/", "")

    -- Build the final URL
    local url = string.format("%s%s/blobs/mainline/--/%s", base_url, project_root, relative_path)
    -- www.codebrowser.com/packages/PACKAGE_NAME/groups/main/--/PATH/TO/FILE/FILE_NAME.EXE

    -- Run the command to open the URL
    --vim.fn.system(string.format("ssh -X local_user@localhost 'xdg-open %s' &", url))
    vim.api.nvim_echo({{url, "None"}}, false, {})
    -- clear the status bar so we don't open a ton of tabs every time we see the message again (alt-tabbing back
    -- to the window, toggling tmux windows, etc) TODO: fix because it executes too fast
    --vim.api.nvim_echo({{"", "None"}}, false, {})
    --vim.fn.system(string.format("ssh -X local_user@localhost 'open %s' &", url))
    -- Send the URL to your local browser through SSH
    -- AL2 doesn't have xdg-open, workaround is to simply print to status bar
    -- and have an iTerm2 trigger that opens the URL matching the regex
    --local cmd = "ssh -X user@localhost 'open " .. url .. "'"
    --os.execute(cmd)
end

-- Map this function to a keybinding in normal mode
vim.keymap.set("n", "<leader>fc", open_in_code_browser, { desc = "Open file in Code Browser" })

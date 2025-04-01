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
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

--leader s to search and replace all instances of word cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- open current file in codebrowser
-- TODO: move to work branch
local function open_in_code_browser()
    local base_url = "https://code.amazon.com/packages/"

    -- Form code browser URL from file path and base
    -- TODO: support branches other than mainline
    local file_path = vim.fn.expand("%:p")
    local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") 
    local relative_path = file_path:gsub(".*/" .. project_root .. "/", "")
    local url = string.format("Link: %s%s/blobs/mainline/--/%s", base_url, project_root, relative_path)

    -- TODO: verify not possible on dev desks
    -- Send the URL to your local browser through SSH
    --local cmd = "ssh -X user@localhost 'open " .. url .. "'"
    --os.execute(cmd)
    --
    -- TEMP: disable trigger and clearing; for now just click on the link provided in status bar
    -- with cmd+click. This is because trigger function for separating and automatically opening
    -- the link is not working as expected

    -- AL2 doesn't have xdg-open, workaround is to simply print to status bar and have an iTerm2 trigger that opens the URL matching the regex
    vim.api.nvim_echo({{url, "None"}}, false, {})
    -- clear the status bar so we don't open a ton of tabs every time we toggle back to the window
    --local file_name = string.sub(file_path, file_path:match(".*/()"), -1)
    --vim.defer_fn(function()
    --    vim.api.nvim_echo({{"Opened `" .. file_name .. "` in code browser", "None"}}, false, {})
    --end, 1000) -- raise if iTerm2 isn't triggering
    -- Creating Trigger:
    -- 1. open iTerm2 preferences
    -- 2. profile > advances > Edit Triggers
    -- 3. new trigger
    --     regular expression: {Opening}xttps://code.amazon.com/packages/.+
    --          replace the 'x' with an 'h'
    --     action: Run Command
    --     parameters: echo \0 | cut -d'}' -f2 | open
end

vim.keymap.set("n", "<leader>fc", open_in_code_browser, { desc = "Open file in Code Browser" })

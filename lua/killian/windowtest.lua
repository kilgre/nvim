--return {}
--local function pep()
--    -- Main module for the Pep Talk Plugin
--    --local M = {}
--
--    -- Load messages from the file at file_path
--    -- Add plugin_dir to default path
--    --if file_path == "../data/messages.csv" then
--    --    local plugin_dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
--    --    file_path = plugin_dir .. file_path
--    --end
--
--    --local file = io.open(file_path, "r")
--    --if not file then
--    --    vim.notify("Failed to load messages file: " .. file_path, vim.log.levels.ERROR)
--    --    return
--    --end
--
--    ---- Clear existing messages
--    --M.messages = {}
--
--    -- Read lines from the file and store them in the messages table
--    --for line in file:lines() do
--    --    if line and line ~= "" then
--    --        table.insert(M.messages, line)
--    --    end
--    --end
--
--    --file:close()
--
--    -- Table to store motivational messages
--    local messages = {"This is a test message for pep talk 2", "test2"}
--
--    -- Display the motivational message in a popup
--    local message = messages[math.random(#messages)]
--
--    local width = 80
--
--    -- Wrap the message
--    local wrapped_message = wrap_text(message, width)
--    wrapped_message[1] = " " .. wrapped_message[1]
--    -- Wrap text so it fits the space better
--    local lines = {}
--    for line in text:gmatch("[^\n]+") do
--        local current_line = ""
--        for word in line:gmatch("%S+") do
--            if #current_line + #word + 1 > width then
--                table.insert(lines, current_line)
--                current_line = word
--            else
--                current_line = current_line == "" and word or current_line .. " " .. word
--            end
--        end
--        if current_line ~= "" then
--            table.insert(lines, current_line)
--        end
--    end
--    return lines
--
--
--    -- Define the popup window options
--    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
--    vim.api.nvim_buf_set_lines(buf, 0, -1, false, wrapped_message)
--
--    local win_width = nil
--    if #message < width then
--        win_width = #message + 4
--    else
--        win_width = width + 4
--    end
--    local win_height = 3
--
--    local row = math.floor((vim.o.lines - win_height) / 2)
--    local col = math.floor((vim.o.columns - win_width) / 2)
--
--    local win_id = vim.api.nvim_open_win(buf, true, {
--        relative = "editor",
--        width = win_width,
--        height = win_height,
--        row = row,
--        col = col,
--        style = "minimal",
--        border = "rounded",
--    })
--
--    -- Close the popup automatically after a short delay
--    vim.defer_fn(function()
--        vim.api.nvim_win_close(win_id, true)
--        vim.api.nvim_buf_delete(buf, { force = true })
--    end, 10000) -- 5000 ms = 5 seconds
--end
--

local function windowTest()
    vim.api.nvim_echo({{"pep2 triggered", "None"}}, false, {})
    -- Define the popup window options
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"This is a test message for pep window"})

    local win_width = nil
    win_width = 80 + 4
    local win_height = 3

    local row = math.floor((vim.o.lines - win_height) / 2)
    local col = math.floor((vim.o.columns - win_width) / 2)

    local win_id = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    -- Close the popup automatically after a short delay
    vim.defer_fn(function()
        vim.api.nvim_win_close(win_id, true)
        vim.api.nvim_buf_delete(buf, { force = true })
    end, 10000) -- 5000 ms = 5 seconds
end

vim.keymap.set("n", "<leader>fp", windowTest, { desc = "Test window" })

-- config
local alias="kilgre"
local title_length = 80

-- constants
local help_string = "q: quit, o: open link on cursor, [1-9]: open by index, <enter>: show more info"
local link_template = "https://code.amazon.com/reviews/%s/revisions/%s#"
local v_sep = "┃"
local h_sep = "━"
local b_sep = "╋"

local function pad_right_with_spaces(s, length)
    return string.format("%s%s", s, string.rep(" ", length-#s))
end

local function pad_left_with_spaces(s, length)
    return string.format("%s%s", string.rep(" ", length-#s), s)
end

local function format_latest_time(seconds)
    local number = seconds
    local suffix = "s"
    if seconds < 60 then
        number = seconds
        suffix = "s"
    elseif seconds < 3600 then
        number = math.floor(seconds / 60)
        suffix = "m"
    elseif seconds < 86400 then
        number = math.floor(seconds / 3600)
        suffix = "h"
    else
        number = math.floor(seconds / 86400)
        suffix = "d"
    end
    return string.format("%s%s", number, suffix)
end

local function get_packages_string(tbl)
    local str = ""
    for _, v in ipairs(tbl) do
        str = str .. "[" .. v .. "]" .. ", "
    end
    return string.sub(str, 0, #str - 2)
end

local function windowTest()
    -- TODO return error message if not authenticated
    local command = string.format("kcurl https://prod.api.dashboard.crux.builder-tools.aws.dev/api/v1/users/%s/reviews | jq '[.codeReviews.[] | select(.sources[] | .interest.type == \"HUMAN\") | {author: .revision.author.id, title: .revision.title, id, rev: .revision.revisionId, packages: .revision.packageNames, lastEventAlias: .newestEvents.events[0].actor.id, eventType: .newestEvents.events[0].eventType, eventTimestamp: .newestEvents.events[0].timestamp}]'", alias)

    local result = vim.fn.system(command)
    -- remove `kcurl` progress output from result
    local trimmed_result = string.sub(result, string.find(result, "[", 1, true), 10000)
    local json_result = vim.json.decode(trimmed_result)

    local win_width = 54 + title_length
    local window_text = {}
    -- TODO reformat into nested table
    local links = {}
    local packages = {}
    local full_titles = {}

    -- TODO replace magic numbers with string length calculations
    table.insert(window_text, string.format("author     %s     title%s %s latest", v_sep, string.rep(" ", title_length-6), v_sep))
    table.insert(window_text, string.format("%s%s%s%s%s", string.rep(h_sep, 11), b_sep, string.rep(h_sep, title_length+5), b_sep, string.rep(h_sep, 35)))

    -- add records to table
    local count = 0
    for _, v in ipairs(json_result) do
        count = count + 1
        local title = v["title"]
        table.insert(full_titles, title)
        -- cut package brackets from title
        local _, snipped_title = title:match("(.+)] (.+)")
        if #snipped_title > title_length - 2 then
            snipped_title = string.format("%s...", string.sub(snipped_title, 1, title_length-4))
        else
            snipped_title = string.format("%s%s", snipped_title, string.rep(" ", title_length-#snipped_title-1))
        end

        local author = string.format("%s@",v["author"])
        author = pad_right_with_spaces(author, 10)
        local rev = v["rev"]
        local rev_string = string.format("r%s", rev)
        table.insert(packages, get_packages_string(v["packages"]))
        local id = v["id"]
        local link = string.format(link_template, id, rev)
        local event = v["eventType"]
        local eventTime = tonumber(v["eventTimestamp"])
        local currentTime = os.time(os.date("!*t"))
        local secondsAgo = math.floor(currentTime - eventTime)
        local timeString = pad_left_with_spaces(format_latest_time(secondsAgo), 5)
        local eventIcon = event
        -- TODO: filter out unwanted statuses first; add all remaining statuses
        if event == "COMMENTS_PUBLISHED" then
            eventIcon = " 󱐒 "
        elseif event == "COMMENT_CREATED" then
            eventIcon = " 󱋊 "
        elseif event == "COMMENT_DELETED" then
            eventIcon = "x󱋊 "
        elseif event == "REVISION_APPROVED" then
            eventIcon = " ✔ "
        elseif event == "REVIEWER_ADDED" then
            eventIcon = " +󰙍"
        elseif event == "ANALYZER_STATUS_REPORTED" then
            eventIcon = " 󱋆 "
        elseif event == "DESCRIPTION_UPDATED" then
            eventIcon = " 󰺪 "
        elseif event == "COMMENT_RESOLVED" then
            eventIcon = "✔󱋊 "
        elseif event == "MARK_REVIEW_READ" or event == "MARK_REVIEW_UNREAD" then
            eventIcon = "  "
        else
            eventIcon = event
        end
        local eventAlias = string.format("%s", v["lastEventAlias"])
        if #eventAlias <= 8 then
            eventAlias = eventAlias .. "@"
        end
        local latestString = string.format("%s %s %s", eventIcon, pad_right_with_spaces(eventAlias, 24), timeString)
        local format_string = "%s "..v_sep.." %s  %s "..v_sep.." %s"
        -- add CR to window
        table.insert(window_text, string.format(format_string, author, rev_string, snipped_title, latestString))
        -- add link to table
        table.insert(links, link)

    end

    -- Add help string to the window
    table.insert(window_text, "")
    table.insert(window_text, help_string)

    -- Define window options
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, window_text)

    -- includes header row, divider row, spacer row, help message
    local win_height = count + 4

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
        title = "Open Code Reviews",
        title_pos = "left"
    })

    -- Setup buffer commands
    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        "",
        { callback = function() vim.api.nvim_win_close(win_id, false) end, noremap = true, silent = true }
    )
    local show_more_info =
        function ()
            local row_index = vim.api.nvim_win_get_cursor(0)[1] - 2
            vim.api.nvim_echo({{string.format("Packages:\t%s\nTitle:\t\t%s\nCR link:\t%s", packages[row_index], full_titles[row_index], links[row_index])}}, false, {})
        end
    local open_link_and_close =
        function(index)
            vim.api.nvim_echo({{string.format("CR link: %s", links[index])}}, false, {})
            vim.api.nvim_win_close(win_id, false)
        end
    local open_link_and_close_on_cursor =
        function()
            local row_index = vim.api.nvim_win_get_cursor(0)[1] - 2
            open_link_and_close(row_index)
        end
    vim.api.nvim_buf_set_keymap(buf, "n", "o", "", { callback = open_link_and_close_on_cursor, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", { callback = show_more_info, noremap = true, silent = true })
    -- quick open by number TODO: there's gotta be a better way to do this
    vim.api.nvim_buf_set_keymap(buf, "n", "1", "", { callback = function () open_link_and_close(1) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "2", "", { callback = function () open_link_and_close(2) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "3", "", { callback = function () open_link_and_close(3) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "4", "", { callback = function () open_link_and_close(4) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "5", "", { callback = function () open_link_and_close(5) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "6", "", { callback = function () open_link_and_close(6) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "7", "", { callback = function () open_link_and_close(7) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "8", "", { callback = function () open_link_and_close(8) end, noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "9", "", { callback = function () open_link_and_close(9) end, noremap = true, silent = true })
end

vim.keymap.set("n", "<leader>tt", windowTest, { desc = "Fetch open CRs" })

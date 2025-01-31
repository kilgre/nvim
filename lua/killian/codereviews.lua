-- config
local alias="kilgre"
local title_length = 80
local v_sep = "┃"
local h_sep = "━"
local b_sep = "╋"

local function pad_right_with_spaces(s, length)
    return string.format("%s%s",s,string.rep(" ",length-#s))
end

local function windowTest()
    local command = string.format("kcurl https://prod.api.dashboard.crux.builder-tools.aws.dev/api/v1/users/%s/reviews | jq '[.codeReviews.[] | select(.sources[] | .interest.type == \"HUMAN\") | {author: .revision.author.id, title: .revision.title, id, rev: .revision.revisionId, packages: .revision.packageNames, lastEventAlias: .newestEvents.events[0].actor.id, eventType: .newestEvents.events[0].eventType}]'",alias)

    local result = vim.fn.system(command)
    -- remove `kcurl` progress output from result
    local trimmed_result = string.sub(result, string.find(result, "[", 1, true), 10000) 
    -- convert string to json for parsing into table
    local json_result = vim.json.decode(trimmed_result)

    local win_width = 50 + title_length
    local window_text = {}
    table.insert(window_text, string.format("author     %s     title%s %s latest",v_sep,string.rep(" ",title_length-6),v_sep))
    table.insert(window_text, string.format("%s%s%s%s%s",string.rep(h_sep,11),b_sep,string.rep(h_sep, title_length+5),b_sep,string.rep(h_sep,30)))

    -- add records to table
    local count = 0
    for k, v in ipairs(json_result) do
        count = count + 1
        local title = v["title"]
        -- cut package brackets from title
        local a,snipped_title = title:match("(.+)](.+)")
        if #snipped_title > title_length then
            snipped_title = string.format("%s...", string.sub(snipped_title, 1, title_length-3))
        else
            snipped_title = string.format("%s%s",snipped_title,string.rep(" ",title_length-#snipped_title))
        end

        local author = string.format("%s@",v["author"])
        author = pad_right_with_spaces(author,10)
        local rev = v["rev"]
        local rev_string = string.format("r%s",rev)
        local packages = v["packages"]
        local id = v["id"]
        local event = v["eventType"]
        local eventIcon = ""
        if event=="COMMENTS_PUBLISHED" then
            eventIcon="💬"
        end
        if event=="REVISION_APPROVED" then
            eventIcon="✓"
        end
        if event=="REVIEWER_ADDED" then
            eventIcon="+"
        end
        local eventAlias = v["lastEventAlias"]
        local format_string = "%s "..v_sep.." %s %s "..v_sep.." %s %s"
        table.insert(window_text, string.format(format_string,author,rev_string,snipped_title,eventAlias,eventIcon))
    end

    -- Define the popup window options
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, window_text)

    -- count of records plus header row and divider row
    local win_height = count + 2

    local row = math.floor((vim.o.lines - win_height) / 2)
    local col = math.floor((vim.o.columns - win_width) / 2)

    local win_id = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "single",
        title = "Open CRs",
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
end

vim.keymap.set("n", "<leader>tt", windowTest, { desc = "Fetch open CRs" })

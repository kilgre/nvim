local function yank_feedback()
    local register = vim.v.register
    local yanked_text = vim.fn.getreg(register)
    local max_length = 28

    -- Truncate the text if it's too long
    if #yanked_text > max_length then
        local truncation_suffix = "..."
        yanked_text = yanked_text:sub(1, max_length - string.len(truncation_suffix)) .. truncation_suffix
    end

    -- Escape special characters for display
    yanked_text = yanked_text:gsub("\n", "\\n"):gsub("\t", "\\t")

    -- Display the message in the status bar
    local message = string.format("'%s' yanked into register '%s'", yanked_text, register)
    vim.api.nvim_echo({{message, "None"}}, false, {})
end

-- Set up an autocommand to trigger this function after yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = yank_feedback,
})


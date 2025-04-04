
-- Written by ChatGPT
function AlignOn(characters)
    -- Escape special characters for Lua pattern matching
    local escaped_chars = characters:gsub("([%p])", "%%%1")
    local pattern = "[" .. escaped_chars .. "]"

    -- Detect visual selection range
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- Extract lines
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Find the maximum position for each alignment point
    local max_pos = {}
    for _, line in ipairs(lines) do
        local pos = 1
        for match in line:gmatch(pattern) do
            max_pos[pos] = math.max(max_pos[pos] or 0, line:find(match))
            pos = pos + 1
        end
    end

    -- Align the lines
    for i, line in ipairs(lines) do
        local new_line = line
        local pos = 1
        for match in line:gmatch(pattern) do
            local curr_pos = new_line:find(match)
            local spaces = string.rep(" ", max_pos[pos] - curr_pos)
            new_line = new_line:gsub(match, spaces .. match, 1)
            pos = pos + 1
        end
        lines[i] = new_line
    end

    -- Replace the lines in the buffer
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- Create a user command for convenience
vim.api.nvim_create_user_command('AlignOn', function(opts)
    AlignOn(opts.args)
end, { nargs = 1, range = true })

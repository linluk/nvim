
-- @param pattern the pattern to be searched
-- @param start_line the line to begin to search from
-- @param limit_line look up to this line to search for the pattern
-- @return the linenumber the pattern was found
local function findPatternLineNumber(pattern, start_line, limit_line)
    local direction
    if limit_line > start_line then
        direction = 1
    elseif limit_line < start_line then
        direction = -1
    else
        print("limit_line must not be equal to start_line")
        return -1
    end

    local line_number = start_line - direction
    local tmp_line = ""
    while line_number ~= limit_line and not tmp_line:match(pattern) do
        line_number = line_number + direction
        tmp_line = vim.fn.getline(line_number)
    end

    return line_number
end

function PipeToExternal(cmd)
    local DEBUG = false
    if not cmd or cmd == "" then
        print("No command specified.")
        return
    end

    local cursor_line = vim.fn.line(".")
    local last_line = vim.fn.line("$")

    local code_start_line = findPatternLineNumber("^```", cursor_line, 1)
    local code_end_line = findPatternLineNumber("^```", cursor_line, last_line)

    -- sanity check
    if code_start_line <= 1 or code_end_line >= last_line or code_end_line < code_start_line then
        print("No valid code block boundaries found.")
        if DEBUG then
            print("cursor_line: ", cursor_line)
            print("last_line: ", last_line)
            print("code_start_line: ", code_start_line)
            print("code_end_line: ", code_end_line)
        end
        return
    end

    -- exclude marker lines
    code_start_line = code_start_line + 1
    code_end_line = code_end_line - 1

    -- get the source code from the code block
    local code_lines = vim.fn.getline(code_start_line, code_end_line)
    local code_text
    if type(code_lines) == "string" then
        code_text = code_lines
    else
        code_text = table.concat(code_lines, "\n")
    end
    --print(code_text)

    -- execute the command
    local output_text = vim.fn.system(cmd, code_text)
    local output_lines = vim.split(output_text, "\n")
    while output_lines[#output_lines] == "" do
        table.remove(output_lines, #output_lines)
    end

    -- surround the output with markers
    table.insert(output_lines, 1, "```text/result")
    table.insert(output_lines, "```")

    -- find "old" text/result marker (only a very near one!)
    local result_start_line = findPatternLineNumber("^```text/result", code_end_line, code_end_line + 5)
    local result_end_line = 0
    if result_start_line > code_end_line and result_start_line < code_end_line + 5 then
        -- old result found
        result_end_line = findPatternLineNumber("^```", result_start_line + 1, last_line)
        if DEBUG then
            print("old result found!")
            print("result_start_line: ", result_start_line)
            print("result_end_line: ", result_end_line)
        end
    else
        -- No old result found
        vim.api.nvim_buf_set_lines(0, code_end_line + 1, code_end_line + 1, false, {""})
        vim.api.nvim_buf_set_lines(0, code_end_line + 1, code_end_line + 1, false, {""})
        result_start_line = code_end_line + 3
        result_end_line = result_start_line
        if DEBUG then
            print("NO old result found!")
            print("result_start_line: ", result_start_line)
            print("result_end_line: ", result_end_line)
        end
    end
    -- replace or insert result
    vim.api.nvim_buf_set_lines(0, result_start_line - 1, result_end_line, false, output_lines)
end

function PipeToPython()
    PipeToExternal("python3")
end

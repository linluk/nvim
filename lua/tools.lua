
-- add something (f.e.: foldmarkers) around a visual block
function add_something_around_vblock(before, after)
    local buf = vim.api.nvim_get_current_buf()
    local start_line_number = vim.api.nvim_buf_get_mark(buf, "<")[0]
    local end_line_number = vim.api.nvim_buf_get_mark(buf, ">")[0]
    local start_line = vim.api.nvim_buf_get_text(buf, start_line_number, 0, start_line_number, -1, {})
    local end_line = vim.api.nvim_buf_get_text(buf, end_line_number, 0, end_line_number, -1, {})
    vim.api.nvim_buf_set_text(buf, start_line_number, 0, start_line_number, #start_line, {start_line, before})
    vim.api.nvim_buf_set_text(buf, end_line_number, #end_line, end_line_number, #end_line, {end_line, after})
--    local mode = vim.api.nvim_get_mode().mode
--    if mode == "v" then
--        local cursor_line = vim.fn.line(".")
--        local visual_line = vim.fn.line("v")
--        local start_line = math.min(cursor_line, visual_line)
--        local end_line = math.max(cursor_line, visual_line)
--        local buf = vim.api.nvim_get_current_buf()
--        vim.api.nvim_buf_set_text(buf, start_line, -1, start_line, -1, before)
--        vim.api.nvim_buf_set_text(buf, end_line, -1, end_line, -1, after)
--    else
--        print("Not in Visual Mode. mode=", mode)
--    end
end
--add_something_around_vblock("{{{", "}}}")

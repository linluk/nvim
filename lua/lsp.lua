
local find_root = function (pattern)
    local root_dir = vim.fs.dirname(
        vim.fs.find(pattern, {upward = true})[1])
    if root_dir == nil then
        root_dir = '.'
    end
    return root_dir
end

-- REQUIRES: clangd
-- INSTALL:  sudo apt install clangd
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "h"},
    callback = function ()
        local client = vim.lsp.start({
            name = 'clangd',
            cmd = {'clangd'},
            root_dir = find_root({'main.c', 'Makefile', '.git'})
        })
        vim.lsp.buf_attach_client(0, client)
    end
})

-- REQUIRES: pylsp
-- INSTALL:  sudo apt install python3-pylsp
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python"},
    callback = function ()
        local client = vim.lsp.start({
            name = 'pylsp',
            cmd = {'pylsp'},
            root_dir = find_root({'main.py', 'venv', '.venv', '.git'})
        })
        vim.lsp.buf_attach_client(0, client)
    end
})

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- navigate buffers
vim.keymap.set("n", "ö", "<CMD>bN<CR>")
vim.keymap.set("n", "ä", "<CMD>bn<CR>")

-- navigate windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- open/close windows
vim.keymap.set("n", "<leader>j", "<CMD>split<CR>")
vim.keymap.set("n", "<leader>l", "<CMD>vsplit<CR>")
vim.keymap.set("n", "<leader>h", "<C-w>l<CMD>hide<CR>")
vim.keymap.set("n", "<leader>k", "<C-w>j<CMD>hide<CR>")
vim.keymap.set("n", "<leader>x", "<CMD>hide<CR>")
vim.keymap.set("n", "<leader>X", "<CMD>only<CR>")

-- first column "0", so last should be ß on a german kb-layout
vim.keymap.set({"n", "v", "o"}, "ß", "$")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', '<C-o>', opts)
        vim.keymap.set('i', '<C-space>', vim.lsp.buf.signature_help, opts)
        --vim.keymap.set('i', '<C-space>', vim.lsp.buf.completion, opts)
        --vim.keymap.set('i', '<C-space>', vim.lsp.buf.omnifunc, opts)
        -- rather use omnifunc <C-x><C-o> instead.
        --vim.opt.omnifunc = vim.lsp.buf.omnifunc
        vim.keymap.set({'n', 'i'}, '<A-return>', vim.lsp.buf.code_action, opts)
    end})


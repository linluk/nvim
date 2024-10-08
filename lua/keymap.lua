vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { silent = true, noremap = true }

-- navigate buffers
vim.keymap.set("n", "ö", "<CMD>bN<CR>", opts)
vim.keymap.set("n", "ä", "<CMD>bn<CR>", opts)

-- navigate windows
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- open/close windows
vim.keymap.set("n", "<leader>j", "<CMD>split<CR>", opts)
vim.keymap.set("n", "<leader>l", "<CMD>vsplit<CR>", opts)
vim.keymap.set("n", "<leader>h", "<C-w>l<CMD>hide<CR>", opts)
vim.keymap.set("n", "<leader>k", "<C-w>j<CMD>hide<CR>", opts)
vim.keymap.set("n", "<leader>x", "<CMD>hide<CR>", opts)
vim.keymap.set("n", "<leader>X", "<CMD>only<CR>", opts)
-- resize windows
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -1<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +1<CR>", opts)
vim.keymap.set("n", "<C-Up>", "<CMD>resize -1<CR>", opts)
vim.keymap.set("n", "<C-Down>", "<CMD>resize +1<CR>", opts)

-- first column "0", so last should be ß on a german kb-layout
vim.keymap.set({"n", "v", "o"}, "ß", "$", opts)

-- unhighlight words on esc in normal mode
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", opts)

-- quickly open nvim config
vim.keymap.set("n", "<leader>ec", ":e ~/.config/nvim/", { noremap = true, desc = "[E]dit Neovim [C]onfiguration" })

local lsp_attach_group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function (args)
        local lsp_opts = { buffer = args.buf, silent = true, noremap = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, lsp_opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, lsp_opts)
        --vim.keymap.set('n', 'go', '<C-o>', lsp_opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, lsp_opts)
        vim.keymap.set('i', '<C-K>', vim.lsp.buf.signature_help, lsp_opts)
        --vim.keymap.set('i', '<C-space>', vim.lsp.buf.completion, opts)
        -- rather use omnifunc <C-x><C-o> instead.
        -- omnifunc is set by default!
        vim.keymap.set({'n', 'i'}, '<A-return>', vim.lsp.buf.code_action, lsp_opts)
    end})

local markdown_group = vim.api.nvim_create_augroup('MarkdownGroup', { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.md",
    group = markdown_group,
    callback = function (args)
        --print("
        local md_opts = { buffer = args.buf, silent = true, noremap = true }
        vim.keymap.set('n', '<leader>ip', "i```<CR><CR>```<up>", md_opts) -- [i]nsert [p]ython code block
        vim.keymap.set('n', '<leader>rp', "<CMD>lua PipeToPython()<CR>", md_opts) -- [r]un [p]ython
    end})




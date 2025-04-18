vim.g.mapleader = ","
vim.g.maplocalleader = ","

local function map(mode, lhs, rhs, desc, silent, buffer, expr)
    if desc == nil then
        desc = string.format("%smap %s %s", mode, lhs, rhs)
    end
    if silent == nil then
        silent = true
    end
    if expr == nil then
        expr = false
    end
    local opts
    if buffer == nil then
        opts = { noremap = true, silent = silent, desc = desc, expr = expr }
    else
        opts = { buffer = buffer, noremap = true, silent = silent, desc = desc, expr = expr }
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("t", "<ESC>", "<C-\\><C-n>", "Use [ESC] to enter normal mode in :terminal buffer")

-- navigate soft lines
map("n", "j", "gj")
map("n", "k", "gk")

-- navigate buffers
map("n", "ö", "<CMD>bN<CR>", "Use [ö] and [ä] (next to [hjkl] on german keyboard) to cycle buffers")
map("n", "ä", "<CMD>bn<CR>", "Use [ö] and [ä] (next to [hjkl] on german keyboard) to cycle buffers")

-- navigate windows
map("n", "<C-h>", "<C-w>h", "Simple Window navigation")
map("n", "<C-j>", "<C-w>j", "Simple Window navigation")
map("n", "<C-k>", "<C-w>k", "Simple Window navigation")
map("n", "<C-l>", "<C-w>l", "Simple Window navigation")
-- open/close windows
map("n", "<leader>j", "<CMD>split<CR>", "Split window below")
map("n", "<leader>l", "<CMD>vsplit<CR>", "Split window right")
map("n", "<leader>h", "<C-w>l<CMD>hide<CR>", "Close right window")
map("n", "<leader>k", "<C-w>j<CMD>hide<CR>", "Close below window")
map("n", "<leader>x", "<CMD>hide<CR>", "Close current window")
map("n", "<leader>X", "<CMD>only<CR>", "Close other windows")
-- resize windows
map("n", "<C-Left>", "<CMD>vertical resize -1<CR>", "Shrink current window width")
map("n", "<C-Right>", "<CMD>vertical resize +1<CR>", "Grow current window width")
map("n", "<C-Up>", "<CMD>resize -1<CR>", "Shrink current window height")
map("n", "<C-Down>", "<CMD>resize +1<CR>", "Grow current window height")

-- unhighlight words on esc in normal mode
map("n", "<Esc>", "<CMD>nohlsearch<CR>", "Unhighlight search on <ESC> in normal mode")

-- quickly open nvim config
map("n", "<leader>ec", ":e ~/.config/nvim/", "[E]dit Neovim [C]onfiguration", false)

-- toggle wrap
map("n", "<leader>w", "<CMD>set invwrap<CR>", "Invert [W]rap")

map("n", "<A-k>", "<CMD>lua vim.diagnostic.open_float()<CR>", "Show diagnostics on Alt+k")

-- use space to toggle folding
map("n", "<space>", "za", "Toggle Folding")

-- first column "0", so last should be ß on a german kb-layout
map({"n", "v", "o"}, "ß", "$", "Use [ß] instead of [$] (next to [0] on german keyboard)")

-- make "0" jump between first character and first non-blank charakter
map({"n", "v", "o"}, "0", function ()
    if vim.fn.col('.') == 1 then
        return "^"
    else
        return "0"
    end
end, nil, nil, nil, true)
map({"n", "v", "o"}, "<leader>0", "0", "<leader>0 forces 0, usefull in macros")

-- abbreviations
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group = vim.api.nvim_create_augroup("AbbrevC", { clear = true }),
    callback = function (args)
        local _map = function (m, l, r, d)
            map(m, l, r, string.format("C-Abbrev: %s", d), nil, args.buf)
        end
        _map("ia", "#i", "#include", "#i becomes #include")
        _map("ia", "#d", "#define", "#d becomes #define")
    end})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group = vim.api.nvim_create_augroup("AbbrevMisc", { clear = true }),
    callback = function (args)
        local _map = function (m, l, r, d)
            map(m, l, r, string.format("C-Abbrev: %s", d), nil, args.buf)
        end
        -- wtfpl {{{
        local wtfpl = "            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE\
                    Version 2, December 2004\
\
 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>\
\
 Everyone is permitted to copy and distribute verbatim or modified\
 copies of this license document, and changing it is allowed as long\
 as the name is changed.\
\
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE\
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\
\
  0. You just DO WHAT THE FUCK YOU WANT TO.\
"
        -- wtfpl }}}
        -- cheader {{{
        local cheader = function()
            local fn = vim.fn.expand('%:t'):upper() -- get the filename, only the filename
            fn = fn:gsub('%.', '_')
            return '#ifndef ' .. fn .. '\n#define ' .. fn .. '\n\n\n#endif /* ' .. fn .. ' */'
        end
        -- cheader }}}
        _map("ia", "((wtf))", wtfpl, "insert the WTFPL license text")
        _map("ia", "((eke))", "Elektrotechnik, Kommunikation und Elektronik", "")
        _map("ia", "((tfbs))", "Tiroler Fachberufsschule", "")
        _map("ia", "((tfbs-eke))", "Tiroler Fachberufsschule für Elektrotechnik, Kommunikation und Elektronik", "")
        _map("ia", "((c-header))", cheader(), "")
        _map("ia", "((c))", "(C) Lukas Singer <ESC>:r !date +\\%Y<CR>kJA", "")
    end})

local lsp_attach_group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function (args)
        local _map = function (m, l, r, d)
            map(m, l, r, string.format("LSP: %s", d), nil, args.buf)
        end
        _map('n', 'gd', vim.lsp.buf.definition, "[G]o to [D]efinition")
        _map('n', 'gD', vim.lsp.buf.declaration, "[G]o to [D]eclaration")
        _map('n', 'gi', vim.lsp.buf.implementation, "[G]o to [I]mplementation")
        --_map('n', 'go', '<C-o>', lsp_opts)
        _map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
        _map('n', 'K', vim.lsp.buf.hover, "Show documentation")
        _map('i', '<C-K>', vim.lsp.buf.signature_help, "Show signature help")
        --_map('i', '<C-space>', vim.lsp.buf.completion, opts)
        -- rather use omnifunc <C-x><C-o> instead.
        -- omnifunc is set by default!
        _map({'n', 'i'}, '<A-return>', vim.lsp.buf.code_action, "Code action")
    end})


local markdown_group = vim.api.nvim_create_augroup('MarkdownGroup', { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.md",
    group = markdown_group,
    callback = function (args)
        local _map = function (m, l, r, d)
            map(m, l, r, string.format("Markdown: %s", d), nil, args.buf)
        end
        _map('n', '<leader>ip', "i```python<CR><CR>```<up>", "[I]nsert [P]ython code block")
        _map('n', '<leader>rp', "<CMD>lua PipeToPython()<CR>", "[R]un [P]ython code block")
        -- https://heitorpb.github.io/bla/format-tables-in-vim/
        _map("v", "<leader>ft", ":!tr -s ' ' | column -t -s '|' -o '|'<CR>", "[F]ormat [T]able")
        _map("n", "<leader>ft", "{jV}k:!tr -s ' ' | column -t -s '|' -o '|'<CR>", "[F]ormat [T]able")
    end})




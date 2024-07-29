
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.encoding = "UTF-8"

vim.opt.ruler = true

-- use the system clipboard (need  xclip  to be installed)
vim.opt.clipboard = 'unnamedplus'

-- ignore case on search except when using  /cUPPERCASE
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 4

vim.opt.hlsearch = true

vim.opt.signcolumn = 'yes'

vim.cmd('colorscheme evening')

vim.opt.autochdir = true

vim.opt.completeopt = 'menu,menuone,longest,popup,noinsert'

vim.opt.showmatch = true
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum,fuzzy'
vim.opt.wildmode = 'longest,full'

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"help"},
    callback = function () vim.cmd('wincmd L') end
})



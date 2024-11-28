
vim.opt.statusline = table.concat({
    " [%{v:lua.vim.api.nvim_get_mode().mode}]", -- mode (short name)
    " %n: ", -- buffer id
    "%t", -- filename
    "%h", -- [Help]
    "%r", -- [RO]
    "%m", -- [-/+]
    " %y", -- filetype
    "%=", -- spacing
    --"(%o)", -- byte in file buffer (first is 0)
    "[0x%B]", -- byte value under cursor in hex %b in dec
    " %c,%l", -- cursor column, cursor line
    " (%2p%%) "
})


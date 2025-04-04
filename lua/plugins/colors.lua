return {
    "tanvirtin/monokai.nvim",
    config = function ()
        require("monokai").setup({})

        vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "lightmagenta", ctermbg = "lightmagenta" })
        vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    end
}

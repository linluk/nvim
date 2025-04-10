return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "c_sharp", "lua", "vimdoc", "markdown", "markdown_inline", "html", "python" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.g.additional_vim_regex_highlighting = false
    end
}

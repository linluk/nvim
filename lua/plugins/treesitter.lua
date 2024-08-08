return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vimdoc", "markdown", "html", "python" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.g.additional_vim_regex_highlighting = false
    end
}

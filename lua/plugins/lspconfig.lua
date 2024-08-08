return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim"
    },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pylsp",
                "omnisharp"
            }
        })
        local util = require('lspconfig.util')
        local lsp = require("lspconfig")
        lsp.lua_ls.setup({
            root_dir = util.root_pattern({"init.lua", ".git"}),
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    --workspace = { library = { vim.env.RUNTIME } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    --diagnostics = { globals = { 'vim' } }
                }
            }
        })
        lsp.clangd.setup({
            root_dir = util.root_pattern({"main.c", "Makefile", ".git"}),
        })
        lsp.pylsp.setup({
            root_dir = util.root_pattern({"main.py", "requirements.txt", "venv", ".venv", ".git"})
        })
        lsp.omnisharp.setup({
            root_dir = util.root_pattern({"*.csproj", "*.sln", ".git"})
        })
    end
}

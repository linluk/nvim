return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        { 'j-hui/fidget.nvim', opts = {} }
    },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pylsp",
                --"omnisharp@v1.39.8", --https://github.com/OmniSharp/omnisharp-roslyn/issues/2574
                "omnisharp",
                "ltex"--,
                --"html-lsp"
            }
        })

        vim.lsp.config('lua_ls', {
            filetypes = { 'lua' },
            root_markers = { 'init.lua', '.git' },
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    --diagnostics = { globals = { 'vim' } }
                }
            }
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('clangd', {
            filetypes = { 'c', 'h', 'cpp', 'hpp' },
            root_markers = { 'Makefile', '.git' }
        })
        vim.lsp.enable('clangd')

        vim.lsp.config('pylsp', {
            filetypes = { 'python' },
            root_markers = {"requirements.txt", "venv", ".venv", ".git"}
        })
        vim.lsp.enable('pylsp')

        vim.lsp.config('omnisharp', {
            filetypes = { 'cs' },
            root_markers = {"*.csproj", "*.sln", ".git"}
        })
        vim.lsp.enable('omnisharp')

        vim.lsp.config('ltex', {
            filetypes = { 'tex', 'text', 'latex', 'markdown', 'org' },
            settings = {
                ltex = {
                    -- https://valentjn.github.io/ltex/advanced-usage.html#set-language-in-markdown-with-yaml-front-matter
                    language = "de-AT",
                },
            },
            on_attach = function(client, bufnr)
                local utils = require('ltex_utils')
                utils.setup_commands()
                utils.load_dictionaries(client)
            end
        })
        vim.lsp.enable('ltex')

        -- vim.lsp.set_log_level("debug")
    end
}

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
        --[[
        --  THE IDEA:
        --  adding a $PROJECT_ROOT/inc or $PROJECT_ROOT/include or ... directory to
        --  clangd so that i can use jumping and completions and so on.
        local clangd_cmd = { "clangd" }
        local clangd_root = util.root_pattern({"Makefile", ".git"})(vim.fn.expand("%:p"))
        local clangd_inc = clangd_root .. "/inc"
        if os.execute('bash -c "[[ -d \\"' .. clangd_inc .. '\\" ]THIS IS ONLY HERE SO THAT THE COMMENT BLOCK DOES NOT END]"') == 0 then
            table.insert(clangd_cmd, "-I" .. clangd_inc)
        end
        --]]
        lsp.clangd.setup({
            --root_dir = util.root_pattern({"main.c", "Makefile", ".git"}),
            root_dir = util.root_pattern({"Makefile", ".git"}),
            --cmd = clangd_cmd
        })
        lsp.pylsp.setup({
            root_dir = util.root_pattern({"main.py", "requirements.txt", "venv", ".venv", ".git"})
        })
        lsp.omnisharp.setup({
            root_dir = util.root_pattern({"*.csproj", "*.sln", ".git"})
        })
        lsp.ltex.setup({
            settings = {
                ltex = {
                    -- https://valentjn.github.io/ltex/advanced-usage.html#set-language-in-markdown-with-yaml-front-matter
                    language = "de-AT",
                },
            }
        })
        -- vim.lsp.set_log_level("debug")
    end
}

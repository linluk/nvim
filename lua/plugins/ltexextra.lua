return {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex", "text", "org" }, -- Load only for relevant filetypes
    -- dependencies = { "neovim/nvim-lspconfig" }, -- Ensure `ltex` is present
    config = function()
        -- Ensure `ltex` is running before setting up `ltex_extra`
        --local lspconfig = require("lspconfig")
        local ltex = vim.lsp.config["ltex"]

        if ltex then
            -- -- -- -- ltex_extra ist noch(?) nicht nvim 11 "compatibel"
            -- -- -- -- https://github.com/barreiroleo/ltex_extra.nvim/tree/dev
            --pcall(vim.lsp._set_deprecate_lspconfig(false))
            -- -- -- --
            require("ltex_extra").setup({
                load_langs = { "en-US", "de-AT" }, -- Define your preferred languages
                completion = true,                -- Enable completion for `ltex`
                path = vim.fn.expand("~/.ltex-dicts"),                       -- Auto-locate LTeX server
                server_opts = {},                 -- Optional additional server settings
            })
        else
            vim.notify("[ltex_extra] Warning: ltex server not found. Ensure it's installed.", vim.log.levels.WARN)
        end
    end
}

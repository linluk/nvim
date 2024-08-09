return {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }
}
    --[['preservim/vim-markdown',
    ft = 'markdown',
    config = function()
        vim.g.vim_markdown_fenced_languages = { 'python', 'c', 'javascript', 'html', 'css' }
        vim.g.vim_markdown_folding_disabled = true
        vim.g.vim_markdown_no_default_key_mappings = true
    end
}--]]

return {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
        vim.g.vim_markdown_fenced_languages = { 'python', 'c', 'javascript', 'html', 'css' }
    end
}

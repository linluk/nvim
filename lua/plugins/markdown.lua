return {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    config = function ()
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki/
        require("render-markdown").setup({
            link = {
                enabled = true,
                image = '󰥶 ',
                hyperlink = '󰌷 ',
                highlight = 'RenderMarkdownLink',
                custom = {
                    web = { pattern = '^http[s]?://', icon = '󰖟 ', highlight = 'RenderMarkdownLink' },
                    python = { pattern = '%.py$', icon = '󰌠 ', highlight = 'RenderMarkdownLink' },
                },
            },
            heading = {
                border = true
            },
            code = {
                width = "block",
                min_width = 80,
                position = "right"
            },
            pipe_table = {
                enabled = true,
                preset = 'none',
                style = 'full',
                cell = 'padded',
                alignment_indicator = '━',
                border = {
                    '┌', '┬', '┐',
                    '├', '┼', '┤',
                    '└', '┴', '┘',
                    '│', '─',
                },
                head = 'RenderMarkdownTableHead',
                row = 'RenderMarkdownTableRow',
                filler = 'RenderMarkdownTableFill',
            }
        })
    end
}

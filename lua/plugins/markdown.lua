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
                sign = false
                --[[
                border = false,
                width = 'full',
                backgrounds = {
                    'RenderMarkdownH1Bg',
                    'RenderMarkdownH2Bg',
                    'RenderMarkdownH3Bg',
                    'RenderMarkdownH4Bg',
                    'RenderMarkdownH5Bg',
                    'RenderMarkdownH6Bg',
                },
                foregrounds = {
                    'RenderMarkdownH1',
                    'RenderMarkdownH2',
                    'RenderMarkdownH3',
                    'RenderMarkdownH4',
                    'RenderMarkdownH5',
                    'RenderMarkdownH6',
                }
                --]]
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

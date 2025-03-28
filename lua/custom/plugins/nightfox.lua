return {
    'EdenEast/nightfox.nvim',
    config = function()
        require('nightfox').setup {
            options = {
                transparent = true,
            },
        }

        -- Set the theme
        vim.cmd 'colorscheme carbonfox'
    end,
}

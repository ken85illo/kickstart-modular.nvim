return {
    'EdenEast/nightfox.nvim',
    init = function()
        vim.cmd.colorscheme 'carbonfox'
    end,
    config = function()
        require('nightfox').setup {
            options = {
                transparent = true,
            },
        }
    end,
}

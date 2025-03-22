-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
        filesystem = {
            mappings = {
                window = {
                    ['\\'] = 'close_window',
                },
            },
        },
    },
    config = function()
        require('neo-tree').setup {
            window = { width = 35 },
            filesystem = {
                use_libuv_file_watcher = true,
            },

            source_selector = {
                statusline = true,
                truncation_character = '…', -- string
                sources = { -- table
                    {
                        source = 'filesystem', -- string
                        display_name = ' 󰉓 Files ', -- string | nil
                    },
                    {
                        source = 'buffers', -- string
                        display_name = '󰈚 Buffers', -- string | nil
                    },
                    {
                        source = 'git_status', -- string
                        display_name = '  󰊢 Git', -- string | nil
                    },
                },
            },
        }
    end,
}

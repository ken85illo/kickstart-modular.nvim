return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        -- Keyboard shortcuts
        vim.api.nvim_set_keymap('n', '<leader>ta', ':$tabnew<CR>', { noremap = true, desc = 'New Tab' })
        vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = 'Close Current Tab' })
        vim.api.nvim_set_keymap('n', '<leader>tn', ':tabn<CR>', { noremap = true, desc = 'Next Tab' })
        vim.api.nvim_set_keymap('n', '<leader>tp', ':tabp<CR>', { noremap = true, desc = 'Previous Tab' })

        vim.api.nvim_set_keymap('n', '<leader>tm', '', { desc = 'Move tab' })
        -- move current tab to previous position
        vim.api.nvim_set_keymap('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true, desc = 'Move tab to previous' })
        -- move current tab to next position
        vim.api.nvim_set_keymap('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true, desc = 'Move tab to next' })

        vim.opt.termguicolors = true
        require('bufferline').setup {
            options = {
                mode = 'tabs',
                diagnostics = 'nvim_lsp',
                tab_size = 25,
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File Explorer',
                        highlight = 'Directory',
                        separator = true, -- use a "true" to enable the default, or set your own character
                    },
                },
            },
        }
    end,
}

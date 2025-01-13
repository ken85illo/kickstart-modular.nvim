return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- Keyboard shortcuts
    vim.api.nvim_set_keymap('n', '<leader>ta', ':$tabnew<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>tn', ':tabn<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>tp', ':tabp<CR>', { noremap = true })
    -- move current tab to previous position
    vim.api.nvim_set_keymap('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true })
    -- move current tab to next position
    vim.api.nvim_set_keymap('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true })

    vim.opt.termguicolors = true
    require('bufferline').setup {
      options = {
        highlight = { underline = true, sp = 'blue' }, -- Optional
        mode = 'tabs',
        diagnostics = 'nvim_lsp',
        tab_size = 25,
      },
    }
  end,
}

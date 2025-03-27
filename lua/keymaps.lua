-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Navigate between tmux panes
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { silent = true })

-- Resize window using a shortcut
vim.keymap.set('n', '<C-S-Down>', ':resize +2<CR>', { desc = 'Resize Horizontal Split Down' })
vim.keymap.set('n', '<C-S-Up>', ':resize -2<CR>', { desc = 'Resize Horizontal Split Up' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize Vertical Split Down' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize Vertical Split Up' })

-- Show the function signature
vim.keymap.set({ 'i', 'n' }, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Toggle neotree when ctrl + n is pressed
vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>')

-- Toggle terminal using ToggleTerm
-- vim.keymap.set('n', '<leader>tt', "<cmd>ToggleTerm direction='horizontal' size=10<CR>", { desc = 'Toggle terminal (horizontal)' })
-- vim.keymap.set('n', '<leader>ty', "<cmd>ToggleTerm direction='vertical' size=60<CR>", { desc = 'Toggle terminal (vertical)' })
-- vim.keymap.set('n', '<leader>tu', "<cmd>ToggleTerm direction='tab' <CR>", { desc = 'Toggle terminal (tab)' })
-- vim.keymap.set('n', '<leader>ti', "<cmd>ToggleTerm direction='float' <CR>", { desc = 'Toggle terminal (float)' })

-- Copy current path
vim.keymap.set('n', '<leader>y', "<cmd>let @+=expand('%:p')<CR>", { desc = 'Copy current path' })

-- vim: ts=4 sts=4 sw=4 et

-- Leader keymaps that work with which-key
-- This file contains keymaps that should be registered after which-key is loaded

-- Additional helpful keymaps for which-key
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite/Save file' })
vim.keymap.set('n', '<leader>W', '<cmd>wq<CR>', { desc = '[W]rite and quit' })
vim.keymap.set('n', '<leader>x', '<cmd>q<CR>', { desc = 'E[x]it' })
vim.keymap.set('n', '<leader>H', '<cmd>nohlsearch<CR>', { desc = 'Clear [H]ighlights' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [E]xplorer' })
vim.keymap.set('n', '<leader>u', '<cmd>Lazy<CR>', { desc = '[U]pdate plugins (Lazy)' })
vim.keymap.set('n', '<leader>r', '<cmd>source %<CR>', { desc = '[R]eload current file' })

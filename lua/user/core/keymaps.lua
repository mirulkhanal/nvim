-- Core Neovim keymaps configuration
-- This file contains all the basic keymaps

-- Basic keymaps
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>x', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })

-- Test keymap
vim.keymap.set('n', '<leader>t', '<cmd>echo "Leader key works!"<CR>', { desc = 'Test leader' })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Clear highlights on escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- LSP keymaps (these will be overridden by LSP attach function)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix diagnostics' })
vim.keymap.set('n', '<leader>fm', '<cmd>Mason<CR>', { desc = 'Mason (LSP manager)' })

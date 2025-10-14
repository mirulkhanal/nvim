-- Simple Neovim Configuration
-- Basic setup with essential plugins

-- Set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Which-key for keymap hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 0,
    },
  },
})

-- Basic keymaps
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })

-- Test keymap
vim.keymap.set('n', '<leader>t', '<cmd>echo "Leader key works!"<CR>', { desc = 'Test leader' })

print("Simple Neovim config loaded successfully!")

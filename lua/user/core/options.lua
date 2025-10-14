-- Core Neovim options configuration
-- This file contains all the basic vim options

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Basic options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.timeoutlen = 300
vim.o.updatetime = 250
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.scrolloff = 10

-- Command line height (0 = auto-hide when not in use)
vim.o.cmdheight = 1

-- Show command in statusline instead of command line
vim.o.showcmd = true
vim.o.showcmdloc = 'statusline'

-- Colorscheme is set in lua/user/plugins/init.lua (gruvbox-material)

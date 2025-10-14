-- Core Neovim options configuration
-- This file contains all the basic vim options

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to false to disable icons entirely
vim.g.have_nerd_font = false

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

-- Colorscheme
vim.cmd.colorscheme('default')

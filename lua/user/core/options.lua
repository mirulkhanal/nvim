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

-- VSCode-like options
vim.o.wrap = false -- Don't wrap lines
vim.o.linebreak = true -- Break lines at word boundaries
vim.o.breakindent = true -- Maintain indent when wrapping
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 2 -- Size of indent
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.softtabstop = 2 -- Number of spaces for editing
vim.o.smartindent = true -- Smart autoindenting
vim.o.autoindent = true -- Copy indent from current line
vim.o.undofile = true -- Save undo history
vim.o.undolevels = 10000 -- Maximum number of changes that can be undone
vim.o.swapfile = false -- Don't use swapfile
vim.o.backup = false -- Don't create backup files
vim.o.writebackup = false -- Don't create backup before overwriting

-- Command line height (0 = auto-hide when not in use)
vim.o.cmdheight = 1

-- Show command in statusline instead of command line
vim.o.showcmd = true
vim.o.showcmdloc = 'statusline'

-- Colorscheme is set in lua/user/plugins/init.lua (gruvbox-material)

-- Core Neovim autocommands configuration
-- This file contains all the basic autocommands

-- Create a group for our autocommands
local group = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-create dir when writing a file, if it doesn't exist yet
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

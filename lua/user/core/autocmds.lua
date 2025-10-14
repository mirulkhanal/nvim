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

-- Clear command line messages after a delay
local clear_message_timer = nil
vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = group,
  callback = function()
    if clear_message_timer then
      vim.fn.timer_stop(clear_message_timer)
    end
    clear_message_timer = vim.fn.timer_start(3000, function()
      vim.cmd('echo ""')
    end)
  end,
})

-- Also clear messages after certain events
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
  group = group,
  callback = function()
    vim.defer_fn(function()
      vim.cmd('echo ""')
    end, 100)
  end,
})

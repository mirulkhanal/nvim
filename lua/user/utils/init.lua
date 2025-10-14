-- Utility functions for the user configuration
-- This module provides common helper functions

local M = {}

-- Helper function to create keymaps with consistent options
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Helper function to create autocommands
function M.create_autocmd(event, opts)
  local default_opts = {
    pattern = '*',
    callback = function() end,
  }
  local options = vim.tbl_extend('force', default_opts, opts)
  vim.api.nvim_create_autocmd(event, options)
end

-- Helper function to check if a plugin is available
function M.has_plugin(name)
  return require('lazy.core.config').plugins[name] ~= nil
end

-- Helper function to get the root directory of a git repository
function M.get_git_root()
  local handle = io.popen('git rev-parse --show-toplevel 2>/dev/null')
  if not handle then
    return nil
  end
  local result = handle:read('*a')
  handle:close()
  return vim.trim(result)
end

-- Helper function to check if we're in a git repository
function M.is_git_repo()
  return M.get_git_root() ~= nil
end

return M

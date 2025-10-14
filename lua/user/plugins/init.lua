-- Plugin manager setup
-- This file sets up lazy.nvim and loads all plugins

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
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          -- Fallback icons when Nerd Font is not available
          Up = '↑',
          Down = '↓',
          Left = '←',
          Right = '→',
          C = 'Ctrl+',
          M = 'Alt+',
          D = 'Cmd+',
          S = 'Shift+',
          CR = 'Enter',
          Esc = 'Esc',
          Space = 'Space',
          Tab = 'Tab',
          F1 = 'F1', F2 = 'F2', F3 = 'F3', F4 = 'F4',
          F5 = 'F5', F6 = 'F6', F7 = 'F7', F8 = 'F8',
          F9 = 'F9', F10 = 'F10', F11 = 'F11', F12 = 'F12',
        },
      },
    },
  },
})

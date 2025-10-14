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
        mappings = false, -- Disable all icons
      },
    },
  },

  -- Mason for LSP server management
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = {
        'typescript-language-server',
        'eslint-lsp',
        'json-lsp',
        'prettier',
      },
    },
  },

  -- Mason LSP config
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    opts = {
      auto_install = true,
      ensure_installed = {
        'ts_ls',
        'eslint',
        'jsonls',
      },
    },
  },

  -- JSON Schema Store
  {
    'b0o/schemastore.nvim',
  },

  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'b0o/schemastore.nvim' },
    },
    config = function()
      require('user.lsp')
    end,
  },
})

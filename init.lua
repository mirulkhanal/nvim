-- Modular Neovim Configuration
-- Clean, organized configuration structure

-- Load core configurations
require('user.core.options')
require('user.core.keymaps')
require('user.core.runner')
require('user.core.autocmds')
require('user.core.highlights')
require('user.lsp')

-- Load plugins
require('user.plugins')

-- MeeruleNvim config loaded successfully

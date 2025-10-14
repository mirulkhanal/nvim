-- Modular Neovim Configuration
-- Clean, organized configuration structure

-- Load core configurations
require('user.core.options')
require('user.core.keymaps')
require('user.core.autocmds')
require('user.core.highlights')

-- Load plugins
require('user.plugins')

-- Load LSP configuration (optional - only works if language servers are installed via Mason)
require('user.lsp')

-- MeeruleNvim config loaded successfully

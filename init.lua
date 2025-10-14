-- Modular Neovim Configuration
-- Clean, organized configuration structure

-- Load core configurations
require('user.core.options')
require('user.core.keymaps')
require('user.core.autocmds')
require('user.core.highlights')

-- Load plugins
require('user.plugins')

print("MeeruleNvim config loaded successfully!")

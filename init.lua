--[[
=====================================================================
==================== MODULAR NEOVIM CONFIGURATION ====================
=====================================================================

This is your modular Neovim configuration based on kickstart.nvim
but organized in a more maintainable and educational structure.

Structure:
├── init.lua (this file)
└── lua/
    └── user/
        ├── core/
        │   ├── options.lua    - Basic vim options
        │   ├── keymaps.lua    - Basic keymaps
        │   └── autocmds.lua   - Basic autocommands
        ├── plugins/
        │   ├── init.lua       - Plugin manager setup
        │   ├── *.lua          - Individual plugin configs
        │   └── kickstart/     - Kickstart plugin configs
        ├── lsp/
        │   ├── init.lua       - LSP initialization
        │   ├── config/        - LSP configuration files
        │   └── servers/       - Individual language server configs
        └── utils/             - Utility functions

To customize:
1. Add new plugins in lua/user/plugins/
2. Add LSP servers in lua/user/lsp/servers/
3. Modify core settings in lua/user/core/
4. Add custom plugins in lua/custom/plugins/

--]]

-- Load core configurations
require('user.core.options')
require('user.core.keymaps')
require('user.core.autocmds')

-- Load plugins
require('user.plugins')

-- Register leader keymaps after plugins are loaded
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite/Save file' })
vim.keymap.set('n', '<leader>W', '<cmd>wq<CR>', { desc = '[W]rite and quit' })
vim.keymap.set('n', '<leader>x', '<cmd>q<CR>', { desc = 'E[x]it' })
vim.keymap.set('n', '<leader>H', '<cmd>nohlsearch<CR>', { desc = 'Clear [H]ighlights' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [E]xplorer' })
vim.keymap.set('n', '<leader>u', '<cmd>Lazy<CR>', { desc = '[U]pdate plugins (Lazy)' })
vim.keymap.set('n', '<leader>r', '<cmd>source %<CR>', { desc = '[R]eload current file' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

# 🔧 Neovim Configuration Extension Guide

This guide explains how to add new plugins and functionality to your modular Neovim configuration.

## 📁 **Understanding Your Configuration Structure**

```
~/.config/nvim/
├── init.lua                    # Main entry point (45 lines)
├── MODULAR_README.md          # Overview of the setup
├── EXTENSION_GUIDE.md         # This file
└── lua/
    └── user/                  # YOUR main configuration
        ├── core/              # Core Neovim settings
        │   ├── options.lua    # vim options
        │   ├── keymaps.lua    # keymaps
        │   └── autocmds.lua   # autocommands
        ├── plugins/           # Plugin configurations
        │   ├── init.lua       # Plugin manager setup
        │   ├── *.lua          # Individual plugin configs
        │   └── kickstart/     # (removed - now in main plugins/)
        ├── lsp/               # Language Server Protocol
        │   ├── init.lua       # LSP initialization
        │   ├── config/        # LSP configuration files
        │   └── servers/       # Individual language server configs
        └── utils/             # Utility functions
            ├── init.lua       # Helper functions
            └── health.lua     # Health checks
    └── custom/                # Your personal additions
        └── plugins/
            └── init.lua       # Your custom plugins
```

## 🚀 **Adding New Plugins**

### **Method 1: Add to Existing Plugin Files (Recommended for related plugins)**

If you want to add configuration to an existing plugin:

1. **Find the plugin file** in `lua/user/plugins/`
2. **Edit the configuration** directly
3. **Restart Neovim** or run `:source %`

**Example**: Adding telescope extensions to `lua/user/plugins/telescope.lua`:
```lua
-- Add this to the extensions section
extensions = {
  ['ui-select'] = {
    require('telescope.themes').get_dropdown(),
  },
  -- Add your new extension here
  ['my-extension'] = {
    -- configuration
  },
}
```

### **Method 2: Create New Plugin Files (Recommended for new plugins)**

For completely new plugins:

1. **Create a new file** in `lua/user/plugins/`
2. **Add the plugin configuration**
3. **Require it** in `lua/user/plugins/init.lua`
4. **Restart Neovim**

**Example**: Adding a new colorscheme plugin

**Step 1**: Create `lua/user/plugins/catppuccin.lua`:
```lua
-- Catppuccin colorscheme configuration
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
```

**Step 2**: Add to `lua/user/plugins/init.lua`:
```lua
-- Load plugin configurations
require('user.plugins.which-key'),
require('user.plugins.telescope'),
-- ... other plugins ...
require('user.plugins.catppuccin'), -- Add this line
```

### **Method 3: Use Custom Plugins Directory (For personal experiments)**

For plugins you're experimenting with:

1. **Edit** `lua/custom/plugins/init.lua`
2. **Add your plugins** there
3. **They'll be loaded automatically**

**Example**: Adding a personal plugin
```lua
-- lua/custom/plugins/init.lua
return {
  -- My experimental plugin
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
    end,
  },
  
  -- Another experimental plugin
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- configuration
    },
  },
}
```

## 🎯 **Adding New Keymaps**

### **Core Keymaps** (Global keymaps)
Edit `lua/user/core/keymaps.lua`:

```lua
-- Add at the end of the file
-- Custom keymaps
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })
vim.keymap.set('n', '<leader>tt', '<cmd>TodoTrouble<CR>', { desc = 'Open Todo Trouble' })
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble<CR>', { desc = 'Open Trouble' })
```

### **Plugin-Specific Keymaps**
Add them in the plugin's configuration file:

```lua
-- In lua/user/plugins/telescope.lua
vim.keymap.set('n', '<leader>sp', builtin.planets, { desc = '[S]earch [P]lanets' })
```

### **LSP Keymaps**
Add them in `lua/user/lsp/init.lua`:

```lua
-- In the LspAttach callback
map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
```

## 🔧 **Adding Language Servers**

### **Step 1**: Create a server configuration file
Create `lua/user/lsp/servers/typescript.lua`:

```lua
-- TypeScript/JavaScript LSP configuration
local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Custom keymaps for this server
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end
    
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  end,
  
  settings = {
    typescript = {
      inlayHints = {
        enabled = true,
      },
    },
    javascript = {
      inlayHints = {
        enabled = true,
      },
    },
  },
}
```

### **Step 2**: Add to the servers list
Edit `lua/user/lsp/init.lua` and add to the servers table:

```lua
local servers = {
  lua_ls = {
    -- existing config
  },
  tsserver = {}, -- Add this line
}
```

### **Step 3**: Add to Mason installation
In the same file, add to ensure_installed:

```lua
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'typescript-language-server', -- Add this
})
```

## 🎨 **Adding New Options**

Edit `lua/user/core/options.lua`:

```lua
-- Add at the end of the file
-- Custom options
vim.o.numberwidth = 4
vim.o.wrap = true
vim.o.linebreak = true
vim.o.spell = true
vim.o.spelllang = 'en_us'
```

## 🔄 **Adding Autocommands**

Edit `lua/user/core/autocmds.lua`:

```lua
-- Add at the end of the file
-- Custom autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'javascript', 'typescript' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
  desc = 'Set 4-space indentation for specific filetypes',
})
```

## 🛠️ **Enabling Optional Plugins**

To enable the optional kickstart plugins, uncomment them in `lua/user/plugins/init.lua`:

```lua
-- Optional plugins (uncomment to enable)
require('user.plugins.autopairs'),      -- Auto-close brackets
require('user.plugins.gitsigns'),       -- Git integration
require('user.plugins.debug'),          -- Debugging support
require('user.plugins.indent-blankline'), -- Indent guides
require('user.plugins.lint'),           -- Linting
```

## 🎯 **Common Extension Patterns**

### **Adding a File Explorer**
```lua
-- lua/user/plugins/explorer.lua
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle Explorer' },
  },
  config = function()
    require('nvim-tree').setup {
      view = {
        width = 30,
      },
    }
  end,
}
```

### **Adding a Status Line**
```lua
-- lua/user/plugins/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight',
    },
  },
}
```

### **Adding a Terminal**
```lua
-- lua/user/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 20,
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
    }
  end,
}
```

## 🚨 **Troubleshooting**

### **Plugin Not Loading**
1. Check the file path is correct
2. Ensure the file is required in `init.lua`
3. Check for syntax errors with `:checkhealth`
4. Restart Neovim completely

### **Keymaps Not Working**
1. Check for conflicts with existing keymaps
2. Ensure the plugin is loaded before setting keymaps
3. Use `:checkhealth which-key` to see keymap conflicts

### **LSP Not Working**
1. Run `:Mason` to install the language server
2. Check `:checkhealth lsp`
3. Restart the LSP with `:LspRestart`

## 📚 **Useful Commands**

- `:Lazy` - Plugin manager
- `:Mason` - LSP/tool installer
- `:checkhealth` - Check configuration health
- `:source %` - Reload current file
- `:Lazy reload` - Reload plugin
- `:LspInfo` - Show LSP status
- `:Telescope` - Fuzzy finder

## 🎯 **Next Steps**

1. **Explore existing plugins** - Look at the files in `lua/user/plugins/`
2. **Enable optional plugins** - Uncomment what you need
3. **Add your favorite plugins** - Use the patterns above
4. **Customize keymaps** - Make them work for your workflow
5. **Set up LSP servers** - For your programming languages

Happy customizing! 🚀

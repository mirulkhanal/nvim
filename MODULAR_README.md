# Modular Neovim Configuration

This is your modular Neovim configuration, based on kickstart.nvim but organized for better maintainability and learning.

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── init.lua.backup            # Backup of original kickstart config
├── MODULAR_README.md          # This file
└── lua/
    └── user/                  # Your main configuration
        ├── core/              # Core Neovim settings
        │   ├── options.lua    # vim options (line numbers, mouse, etc.)
        │   ├── keymaps.lua    # Basic keymaps
        │   └── autocmds.lua   # Basic autocommands
        ├── plugins/           # Plugin configurations
        │   ├── init.lua       # Lazy.nvim setup and plugin loading
        │   ├── which-key.lua  # Which-key configuration
        │   ├── telescope.lua  # Telescope fuzzy finder
        │   ├── lsp.lua        # LSP plugin setup
        │   ├── conform.lua    # Autoformatting
        │   ├── blink-cmp.lua  # Autocompletion
        │   ├── tokyonight.lua # Colorscheme
        │   ├── todo-comments.lua # Todo highlighting
        │   ├── mini.lua       # Mini.nvim utilities
        │   ├── treesitter.lua # Syntax highlighting
        │   └── kickstart/     # Kickstart plugin configs
        │       └── neo-tree.lua # File explorer
        ├── lsp/               # Language Server Protocol
        │   ├── init.lua       # LSP initialization
        │   ├── config/        # LSP configuration files
        │   └── servers/       # Individual language server configs
        └── utils/             # Utility functions
            └── init.lua       # Helper functions
    └── custom/                # Custom plugins (your additions)
        └── plugins/
            └── init.lua       # Your custom plugins
```

## 🚀 Getting Started

### 1. Understanding the Structure

- **`init.lua`**: The main entry point that loads your core configurations and plugins
- **`user/core/`**: Contains fundamental Neovim settings
- **`user/plugins/`**: Individual plugin configurations
- **`user/lsp/`**: Language Server Protocol setup
- **`user/utils/`**: Helper functions
- **`custom/plugins/`**: Your personal plugin additions

### 2. Adding New Plugins

#### Option A: Add to existing plugin files
Edit the appropriate file in `lua/user/plugins/` to add configuration.

#### Option B: Create new plugin files
Create a new `.lua` file in `lua/user/plugins/` and require it in `lua/user/plugins/init.lua`.

#### Option C: Use custom plugins directory
Add plugins to `lua/custom/plugins/init.lua` for your personal additions.

### 3. Adding Language Servers

1. Add the server to `lua/user/lsp/servers/` (create a new file)
2. Configure the server in that file
3. Add it to the servers list in `lua/user/lsp/init.lua`

### 4. Modifying Core Settings

- **Options**: Edit `lua/user/core/options.lua`
- **Keymaps**: Edit `lua/user/core/keymaps.lua`
- **Autocommands**: Edit `lua/user/core/autocmds.lua`

## 🔧 Key Features

### Which-Key Integration
Press `<space>` to see available keymaps with emoji icons and better organization.

### Telescope Integration
- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader>sh` - Search help
- `<leader>sk` - Search keymaps

### LSP Integration
- `grn` - Rename symbol
- `gra` - Code actions
- `grr` - Find references
- `grd` - Go to definition

### File Explorer
- `<leader>e` - Toggle Neo-tree file explorer

## 🎨 Customization Examples

### Adding a New Colorscheme

1. Create `lua/user/plugins/my-colorscheme.lua`:
```lua
return {
  'user/colorscheme',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'my-colorscheme'
  end,
}
```

2. Add to `lua/user/plugins/init.lua`:
```lua
require('user.plugins.my-colorscheme'),
```

### Adding a New Language Server

1. Create `lua/user/lsp/servers/typescript.lua`:
```lua
return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      tsserver = {
        settings = {
          typescript = {
            inlayHints = {
              enabled = true,
            },
          },
        },
      },
    },
  },
}
```

### Adding Custom Keymaps

Edit `lua/user/core/keymaps.lua`:
```lua
-- Custom keymap example
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })
```

## 🔄 Migration from Original Kickstart

The original kickstart configuration is backed up as `init.lua.backup`. All functionality has been preserved but organized into modules.

## 📚 Learning Resources

- **Neovim Lua Guide**: `:help lua-guide`
- **Lazy.nvim**: `:help lazy.nvim`
- **LSP Configuration**: `:help lspconfig`
- **Telescope**: `:help telescope`

## 🆘 Troubleshooting

1. **Check health**: `:checkhealth`
2. **Update plugins**: `:Lazy update`
3. **Reload config**: `:source %`
4. **Check logs**: `:Lazy log`

## 🎯 Next Steps

1. Explore the plugin configurations
2. Add your favorite plugins
3. Configure language servers for your tech stack
4. Customize keymaps for your workflow
5. Experiment with different colorschemes

Happy coding! 🚀

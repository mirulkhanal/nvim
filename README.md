# 🚀 My Personal Neovim Configuration

A modular, educational, and maintainable Neovim configuration based on kickstart.nvim but completely reorganized for better understanding and customization.

## ✨ **Features**

- **🎯 Modular Structure** - Easy to understand and extend
- **🔧 Plugin Management** - Lazy.nvim for fast startup
- **🎨 Beautiful UI** - Tokyo Night colorscheme with emoji icons
- **🔍 Fuzzy Finding** - Telescope for files, grep, and more
- **🧠 Smart Completion** - Blink.cmp with LSP integration
- **📝 Language Support** - LSP configuration for multiple languages
- **🎮 Intuitive Keymaps** - Which-key integration with helpful descriptions
- **🔧 Auto-formatting** - Conform.nvim for code formatting
- **🌳 Syntax Highlighting** - Treesitter for better syntax support

## 📁 **Configuration Structure**

```
~/.config/nvim/
├── init.lua                    # Main entry point (45 lines)
├── README.md                   # This file
├── MODULAR_README.md          # Detailed setup guide
├── EXTENSION_GUIDE.md         # How to add plugins and features
├── .gitignore                 # Git ignore file
└── lua/
    └── user/                  # Main configuration
        ├── core/              # Core Neovim settings
        │   ├── options.lua    # vim options
        │   ├── keymaps.lua    # keymaps
        │   └── autocmds.lua   # autocommands
        ├── plugins/           # Plugin configurations
        │   ├── init.lua       # Plugin manager setup
        │   ├── which-key.lua  # Keymap helper
        │   ├── telescope.lua  # Fuzzy finder
        │   ├── lsp.lua        # LSP setup
        │   ├── conform.lua    # Auto-formatting
        │   ├── blink-cmp.lua  # Autocompletion
        │   ├── tokyonight.lua # Colorscheme
        │   ├── todo-comments.lua # Todo highlighting
        │   ├── mini.lua       # Mini utilities
        │   ├── treesitter.lua # Syntax highlighting
        │   ├── neo-tree.lua   # File explorer
        │   ├── autopairs.lua  # Auto-close brackets
        │   ├── gitsigns.lua   # Git integration
        │   ├── debug.lua      # Debugging support
        │   ├── indent-blankline.lua # Indent guides
        │   └── lint.lua       # Linting
        ├── lsp/               # Language Server Protocol
        │   ├── init.lua       # LSP initialization
        │   ├── config/        # LSP configuration files
        │   └── servers/       # Individual language server configs
        └── utils/             # Utility functions
            ├── init.lua       # Helper functions
            └── health.lua     # Health checks
    └── custom/                # Personal additions
        └── plugins/
            └── init.lua       # Custom plugins
```

## 🚀 **Quick Start**

1. **Clone this repository**:
   ```bash
   git clone <your-github-repo> ~/.config/nvim
   ```

2. **Start Neovim**:
   ```bash
   nvim
   ```

3. **Wait for Lazy to install plugins** (first time only)

4. **Press `<space>`** to see available keymaps

## 🎮 **Key Keymaps**

### **General**
- `<leader>w` - Save file
- `<leader>W` - Save and quit
- `<leader>x` - Exit
- `<leader>e` - Toggle file explorer
- `<leader>r` - Reload current file
- `<leader>u` - Open Lazy plugin manager

### **Search & Navigation**
- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader>sh` - Search help
- `<leader>sk` - Search keymaps
- `<leader><leader>` - Find buffers

### **LSP**
- `grn` - Rename symbol
- `gra` - Code actions
- `grr` - Find references
- `grd` - Go to definition
- `grD` - Go to declaration

### **Git** (when gitsigns is enabled)
- `]c` / `[c` - Navigate git changes
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk

## 🔧 **Customization**

### **Enabling Optional Plugins**
Edit `lua/user/plugins/init.lua` and uncomment the plugins you want:

```lua
-- Optional plugins (uncomment to enable)
require('user.plugins.autopairs'),      -- Auto-close brackets
require('user.plugins.gitsigns'),       -- Git integration
require('user.plugins.debug'),          -- Debugging support
require('user.plugins.indent-blankline'), -- Indent guides
require('user.plugins.lint'),           -- Linting
```

### **Adding New Plugins**
See `EXTENSION_GUIDE.md` for detailed instructions.

### **Changing Colorscheme**
Edit `lua/user/plugins/tokyonight.lua` and change:
```lua
vim.cmd.colorscheme 'tokyonight-night'  -- Change to your preferred theme
```

### **Adding Language Servers**
1. Create a new file in `lua/user/lsp/servers/`
2. Add the server to the servers list in `lua/user/lsp/init.lua`
3. Run `:Mason` to install the server

## 📚 **Documentation**

- **`MODULAR_README.md`** - Detailed explanation of the structure
- **`EXTENSION_GUIDE.md`** - How to add plugins and features
- **`:help`** - Neovim built-in help
- **`:help lazy.nvim`** - Plugin manager help
- **`:help telescope`** - Fuzzy finder help

## 🛠️ **Requirements**

- Neovim 0.10+ (latest stable or nightly)
- Git
- Make
- Ripgrep (`rg`)
- fd-find (optional, for better file finding)

## 🚨 **Troubleshooting**

- **`:checkhealth`** - Check for issues
- **`:Lazy`** - Plugin manager
- **`:Mason`** - Install language servers
- **Restart Neovim** if plugins don't load

## 📖 **Learning Resources**

- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Lazy.nvim Documentation](https://lazy.folke.io/)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)

## 🤝 **Contributing**

This is your personal configuration! Feel free to:
- Add new plugins
- Modify existing configurations
- Create your own customizations
- Share improvements

## 📄 **License**

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) which is MIT licensed.

---

**Happy coding! 🎉**

*This configuration is designed to be educational and maintainable. Every file is well-commented to help you understand what's happening and how to extend it.*
# Modular Neovim Configuration

A clean, organized Neovim configuration with a modular structure.

## Structure

```
nvim/
├── init.lua                 # Main entry point
└── lua/
    └── user/
        ├── core/
        │   ├── options.lua   # Basic vim options and leader key
        │   ├── keymaps.lua   # Keybindings
        │   └── autocmds.lua  # Autocommands
        └── plugins/
            └── init.lua      # Plugin manager setup
```

## Features

- **Leader Key**: Space (`<space>`)
- **Plugin Manager**: Lazy.nvim
- **Keymap Hints**: Which-key.nvim (clean, icon-free interface)
- **LSP Support**: Full Language Server Protocol setup
- **Language Servers**: TypeScript/JavaScript, ESLint, JSON with schema validation
- **Auto-formatting**: On save for JS/TS/JSON files

## Keymaps

### Basic Keymaps
- `<leader>w` - Save file
- `<leader>x` - Quit
- `<leader>h` - Clear highlights
- `<leader>t` - Test leader key
- `<leader>e` - Toggle file explorer (Neo-tree)
- `<leader>o` - Focus file explorer
- `<leader>fm` - Open Mason (LSP manager)
- `<C-h/j/k/l>` - Window navigation

### File Explorer (Neo-tree)
- `<leader>e` - Toggle file explorer
- `<leader>o` - Focus file explorer
- `<Enter>` - Open file
- `s` - Open in vertical split
- `S` - Open in horizontal split
- `t` - Open in new tab
- `a` - Add file
- `A` - Add directory
- `d` - Delete file
- `r` - Rename file
- `y` - Copy file
- `x` - Cut file
- `p` - Paste file
- `R` - Refresh
- `?` - Show help

### LSP Keymaps (when LSP is active)
- `gd` - Go to definition
- `gD` - Go to declaration
- `K` - Show documentation
- `gi` - Go to implementation
- `gr` - Show references
- `<leader>D` - Type definition
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>f` - Format code
- `[d` / `]d` - Previous/Next diagnostic
- `<leader>d` - Open diagnostic

## Adding New Plugins

1. Add plugin configuration to `lua/user/plugins/init.lua`
2. Or create individual plugin files in `lua/user/plugins/`

## Adding New Keymaps

Add keymaps to `lua/user/core/keymaps.lua`

## Customization

- **Options**: Modify `lua/user/core/options.lua`
- **Keymaps**: Modify `lua/user/core/keymaps.lua`
- **Autocommands**: Modify `lua/user/core/autocmds.lua`

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
- **Keymap Hints**: Which-key.nvim
- **Basic Keymaps**:
  - `<leader>w` - Save file
  - `<leader>q` - Quit
  - `<leader>h` - Clear highlights
  - `<leader>t` - Test leader key
  - `<C-h/j/k/l>` - Window navigation

## Adding New Plugins

1. Add plugin configuration to `lua/user/plugins/init.lua`
2. Or create individual plugin files in `lua/user/plugins/`

## Adding New Keymaps

Add keymaps to `lua/user/core/keymaps.lua`

## Customization

- **Options**: Modify `lua/user/core/options.lua`
- **Keymaps**: Modify `lua/user/core/keymaps.lua`
- **Autocommands**: Modify `lua/user/core/autocmds.lua`

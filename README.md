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
- **Completion**: LSP, snippets, file paths, and open-buffer words in a popup menu
- **Run current file**: Click `▶ Run` in the statusline or use `<leader>rr`
- **Language Servers**: TypeScript/JavaScript, Lua, and Java, installed through Mason
- **Formatting**: Java formats on save; `<leader>cf` formats an attached language server that supports it
- **Treesitter**: Parser installation, syntax highlighting, indentation, folding, and text objects

## Keymaps

### Basic Keymaps
- `<leader>w` - Save file
- `<leader>x` - Quit
- `<leader>h` - Clear highlights
- `<leader>e` - Toggle file explorer (Neo-tree)
- `<leader>o` - Focus file explorer
- `<leader>m` - Open Mason (LSP manager)
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Search text (Telescope)
- `<leader>cf` - Format the current file through LSP
- `<leader>rr` - Run the current Java, C/C++, Python, JavaScript, Lua, shell, Go, or Rust file
- `▶ Run` in the statusline - Click to run the current supported file
- `:LspInfo` - Show LSP clients attached to the current buffer and formatting support
- Java support requires Java 21 or newer to run JDTLS
- `<C-Space>` - Open the completion menu manually in insert mode
- `<Enter>` - Accept the selected completion
- `<C-n>` / `<C-p>` or arrow keys - Move through completion choices
- In Java, type `psvm` and select the snippet to insert a main method
- `<C-q>` in a terminal - Hide the current terminal while keeping its process running
- `q` in a finished Run terminal - Delete its terminal buffer and output
- `<leader>\q` - Toggle terminal windows from the editor
- `<leader>\f` / `<leader>\h` / `<leader>\v` - Open float / horizontal / vertical terminal
- `<leader>\g` - Open lazygit in a terminal
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
- `<leader>cr` - Rename symbol
- `<leader>ca` - Code action
- `<leader>cf` - Format code
- `[d` / `]d` - Previous/Next diagnostic
- `<leader>dd` - Open diagnostic

## Adding New Plugins

1. Add plugin configuration to `lua/user/plugins/init.lua`
2. Or create individual plugin files in `lua/user/plugins/`

## Adding New Keymaps

Add keymaps to `lua/user/core/keymaps.lua`

## Customization

- **Options**: Modify `lua/user/core/options.lua`
- **Keymaps**: Modify `lua/user/core/keymaps.lua`
- **Autocommands**: Modify `lua/user/core/autocmds.lua`

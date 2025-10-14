# LSP Setup Guide

This Neovim configuration uses **Mason** to manage LSP servers and Neovim's **native LSP client** to provide IDE-like features.

## 🚀 Quick Start for TypeScript

### Step 1: Install TypeScript Language Server

1. Open Neovim: `nvim`
2. Press `<Space>m` to open Mason
3. Search for `typescript-language-server` (or just scroll to find it)
4. Press `i` to install it
5. Wait for installation to complete (you'll see a ✓ when done)
6. Press `q` to close Mason

### Step 2: Use TypeScript Features

1. Open any `.ts`, `.tsx`, `.js`, or `.jsx` file
2. The LSP will automatically start (you'll see "LSP attached" in the status)
3. Use these keymaps:

#### Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show references
- `K` - Show hover documentation

#### Code Actions
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code action
- `<Space>f` - Format file

#### Diagnostics
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `<Space>d` - Show diagnostic in floating window

## 📦 Adding More Language Servers

### For JSON
1. Open Mason: `<Space>m`
2. Install `json-lsp`
3. Restart Neovim

### For Python
1. Open Mason: `<Space>m`
2. Install `pyright` or `pylsp`
3. Restart Neovim

### For Rust
1. Open Mason: `<Space>m`
2. Install `rust-analyzer`
3. Restart Neovim

### For Go
1. Open Mason: `<Space>m`
2. Install `gopls`
3. Restart Neovim

## 🔧 How It Works

1. **Mason** downloads and installs language servers to `~/.local/share/nvim/mason/`
2. **Mason automatically adds them to PATH** so Neovim can find them
3. **Neovim's native LSP client** (`vim.lsp.start()`) connects to these servers
4. **No lspconfig needed** - pure Neovim APIs only

## ⚠️ Troubleshooting

### LSP doesn't start
- Make sure you installed the language server via Mason
- Check if it's installed: `:Mason` and look for the ✓ icon
- Restart Neovim after installing new servers

### "Language server not found" error
- The server might not be in PATH yet
- Try restarting Neovim
- Check `:checkhealth mason` for issues

### Want to add support for a new language?
1. Find the language server name at https://mason-registry.dev/registry/list
2. Install it via Mason
3. Edit `lua/user/lsp/init.lua` to add a new `FileType` autocmd for that language

## 📝 Configuration Files

- `lua/user/lsp/init.lua` - LSP configuration (keymaps, diagnostics, language server setup)
- `lua/user/plugins/init.lua` - Mason plugin configuration
- `lua/user/core/keymaps.lua` - Global keymaps (includes `<Space>m` for Mason)

## 🎯 Benefits of This Approach

✅ **Simple** - No complex plugin dependencies  
✅ **Clean** - Uses only Neovim's native LSP APIs  
✅ **Flexible** - Easy to add new language servers  
✅ **Reliable** - No deprecation warnings  
✅ **Fast** - Minimal overhead  

Enjoy your TypeScript development! 🎉


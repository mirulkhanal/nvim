# LSP Setup Guide (AstroNvim-Style)

This Neovim configuration uses **automatic LSP setup** just like AstroNvim. Install a language server via Mason and it works automatically!

## 🚀 Quick Start

### TypeScript/JavaScript (Already Configured!)

TypeScript and Lua language servers are **automatically installed** on first launch. Just:

1. **Restart Neovim** - Servers will install automatically
2. **Open a TypeScript file** - `test.ts` or any `.ts`/`.js` file
3. **LSP works automatically!** - You'll see "LSP attached: ts_ls" notification

### Test LSP Features

Create a test file to verify LSP is working:

```bash
# Create a test TypeScript file
echo "const greeting: string = 'Hello';" > test.ts

# Open it in Neovim
nvim test.ts
```

Then try these keymaps:
- Hover over `greeting` and press `K` - Should show type information
- Press `gd` on `greeting` - Should go to definition
- Type something wrong and see red underlines (diagnostics)

## 📦 Adding More Language Servers

### Method 1: Automatic (Recommended)
Add to `ensure_installed` in `lua/user/plugins/init.lua`:

```lua
ensure_installed = {
  'ts_ls',      -- TypeScript/JavaScript
  'lua_ls',     -- Lua
  'pyright',    -- Python (add this)
  'rust_analyzer', -- Rust (add this)
  'gopls',      -- Go (add this)
},
```

Restart Neovim and they'll install automatically!

### Method 2: Manual Install
1. Press `<Space>m` to open Mason
2. Find the language server you want (e.g., `pyright` for Python)
3. Press `i` to install
4. **That's it!** It works automatically, no configuration needed

## 🎯 Available Language Servers

Common servers you can install:

| Language | Server Name | Install Command |
|----------|-------------|-----------------|
| TypeScript/JavaScript | `ts_ls` | Already installed |
| Lua | `lua_ls` | Already installed |
| Python | `pyright` | `:MasonInstall pyright` |
| Rust | `rust_analyzer` | `:MasonInstall rust-analyzer` |
| Go | `gopls` | `:MasonInstall gopls` |
| C/C++ | `clangd` | `:MasonInstall clangd` |
| JSON | `jsonls` | `:MasonInstall json-lsp` |
| HTML | `html` | `:MasonInstall html-lsp` |
| CSS | `cssls` | `:MasonInstall css-lsp` |

Full list: https://mason-registry.dev/registry/list

## ⌨️ LSP Keymaps

These work automatically when LSP is active:

### Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show all references
- `K` - Show hover documentation

### Code Actions
- `<Space>rn` - Rename symbol under cursor
- `<Space>ca` - Show code actions
- `<Space>f` - Format current file

### Diagnostics (Errors/Warnings)
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `<Space>d` - Show diagnostic in floating window

### Mason
- `<Space>m` - Open Mason UI

## 🔧 How It Works (AstroNvim-Style)

1. **Mason** installs language servers
2. **mason-lspconfig** bridges Mason and nvim-lspconfig
3. **setup_handlers** automatically configures ALL installed servers
4. **No manual configuration needed** - Just install and use!

```
Mason Install → mason-lspconfig detects it → Auto-configures → LSP works!
```

## ✅ Checking if LSP is Working

### Method 1: Visual Indicators
- Open a code file
- You should see a notification: "LSP attached: server_name"
- Hover over code and press `K` - should show documentation
- Type invalid code - should see red underlines

### Method 2: LSP Info Command
```vim
:LspInfo
```
Shows all active LSP clients for current buffer

### Method 3: Check Installed Servers
```vim
:Mason
```
Look for ✓ icons next to installed servers

## 🌳 Treesitter (Syntax Highlighting)

Treesitter is already configured for:
- TypeScript/JavaScript
- JSON
- Lua
- Vim

To add more languages, edit `lua/user/plugins/init.lua`:

```lua
ensure_installed = { 
  'typescript', 'javascript', 'json', 'lua', 'vim', 'vimdoc',
  'python',  -- Add this
  'rust',    -- Add this
},
```

## ⚠️ Troubleshooting

### LSP doesn't attach
1. Check if server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check health: `:checkhealth mason`
4. Restart Neovim

### No notification when opening file
- The server might be installing in background
- Wait a minute and reopen the file
- Check `:Mason` to see if installation completed

### "Server not found" error
- The server name might be wrong
- Check available servers: https://mason-registry.dev/registry/list
- Make sure you're using the lspconfig name (e.g., `ts_ls` not `typescript-language-server`)

## 🎨 Customization

### Add custom LSP settings
Edit `lua/user/lsp/init.lua` and add a new handler:

```lua
['your_server'] = function()
  require('lspconfig').your_server.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      -- Your custom settings here
    },
  })
end,
```

### Change keymaps
Edit the `on_attach` function in `lua/user/lsp/init.lua`

## 🎉 Benefits

✅ **Automatic** - Install once, works everywhere  
✅ **Zero config** - No manual server setup needed  
✅ **AstroNvim-style** - Same elegant approach  
✅ **Extensible** - Easy to add new languages  
✅ **Fast** - Lazy-loaded and optimized  

Enjoy your fully automatic LSP setup! 🚀

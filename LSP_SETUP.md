# LSP Setup Guide (Pure vim.lsp API)

This Neovim configuration uses **ONLY Neovim's native LSP API** (`vim.lsp.start()`) with Mason for installing servers. No lspconfig, no deprecation warnings!

## 🚀 Quick Start

### TypeScript/JavaScript & Lua (Auto-configured!)

These language servers are **automatically installed** on first launch:
- `typescript-language-server` for TypeScript/JavaScript
- `lua-language-server` for Lua/Neovim config

Just:
1. **Restart Neovim** - Servers install automatically
2. **Open a file** - LSP starts automatically
3. **It just works!** ✨

### Test LSP Features

Create a test file:

```bash
# TypeScript
echo "const greeting: string = 'Hello';" > test.ts
nvim test.ts

# Lua
echo "local x = 'test'" > test.lua
nvim test.lua
```

You should see: **"LSP attached: typescript-language-server"** or **"LSP attached: lua-language-server"**

Then try:
- `K` on a variable → Shows type/documentation
- `gd` → Go to definition
- Type invalid code → See red underlines

## 📦 Adding More Language Servers

### Step 1: Install via Mason
```vim
:Mason
# Find the server (e.g., pyright for Python)
# Press 'i' to install
```

### Step 2: Add LSP Configuration

Edit `lua/user/lsp/init.lua` and add a new FileType autocmd:

```lua
-- Python Language Server (example)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function(args)
    local root_dir = find_root({ 'pyproject.toml', 'setup.py', '.git' })
    
    if vim.fn.executable('pyright-langserver') == 0 then
      vim.notify('pyright not found. Install via :Mason', vim.log.levels.WARN)
      return
    end
    
    vim.lsp.start({
      name = 'pyright',
      cmd = { 'pyright-langserver', '--stdio' },
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})
```

### Step 3: Restart Neovim
Open a Python file and LSP will start automatically!

## 🎯 Currently Configured Languages

| Language | Server | Auto-Install | Status |
|----------|--------|--------------|--------|
| TypeScript/JavaScript | typescript-language-server | ✅ Yes | ✅ Working |
| Lua | lua-language-server | ✅ Yes | ✅ Working |
| Python | pyright | ❌ Manual | ⚙️ Add config |
| Rust | rust-analyzer | ❌ Manual | ⚙️ Add config |
| Go | gopls | ❌ Manual | ⚙️ Add config |

## ⌨️ LSP Keymaps

These work automatically when LSP is active:

### Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show all references
- `K` - Show hover documentation

### Code Actions
- `<Space>rn` - Rename symbol
- `<Space>ca` - Show code actions
- `<Space>f` - Format file

### Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<Space>d` - Show diagnostic details

### Mason
- `<Space>m` - Open Mason UI

## 🔧 How It Works

```
1. Mason installs language servers
   ↓
2. FileType autocmd detects file type
   ↓
3. vim.lsp.start() launches server
   ↓
4. on_attach() sets up keymaps
   ↓
5. LSP features work!
```

**No lspconfig, no deprecation warnings, pure Neovim!**

## ✅ Checking if LSP is Working

### Method 1: Visual Check
- Open a code file
- See notification: "LSP attached: server-name"
- Press `K` on code → Shows documentation
- Type errors → Red underlines appear

### Method 2: LSP Info
```vim
:LspInfo
```
Should show active clients

### Method 3: Check Installed Servers
```vim
:Mason
```
Look for ✓ next to installed servers

## 🌳 Treesitter (Syntax Highlighting)

Already configured for:
- TypeScript/JavaScript
- JSON
- Lua
- Vim

To add more:
```lua
-- Edit lua/user/plugins/init.lua
ensure_installed = { 
  'typescript', 'javascript', 'json', 'lua', 'vim', 'vimdoc',
  'python',  -- Add this
  'rust',    -- Add this
},
```

## ⚠️ Troubleshooting

### "server not found" warning
- Server isn't installed
- Run `:Mason` and install it
- Restart Neovim

### LSP doesn't start
- Check `:LspInfo` - should show attached client
- Check server is executable: `:!which typescript-language-server`
- Check `:checkhealth mason`

### No keymaps working
- LSP might not be attached
- Check for "LSP attached" notification
- Try `:LspInfo` to verify

## 🎨 Adding Custom Language Servers

### Template for New Language

```lua
-- In lua/user/lsp/init.lua, add:

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'your-filetype' },
  callback = function(args)
    local root_dir = find_root({ 'project-file', '.git' })
    
    if vim.fn.executable('your-server-command') == 0 then
      vim.notify('Server not found. Install via :Mason', vim.log.levels.WARN)
      return
    end
    
    vim.lsp.start({
      name = 'your-server-name',
      cmd = { 'your-server-command', '--stdio' },
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        -- Your custom settings
      },
    })
  end,
})
```

## 🎉 Benefits

✅ **No deprecation warnings** - Pure vim.lsp API  
✅ **No lspconfig dependency** - One less plugin  
✅ **Future-proof** - Uses only Neovim native APIs  
✅ **Simple** - Easy to understand and customize  
✅ **Fast** - Minimal overhead  
✅ **Mason integration** - Easy server management  

Enjoy your clean, modern LSP setup! 🚀

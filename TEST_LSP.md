# How to Test LSP Features

## 🚀 Quick Test

### Step 1: Restart Neovim
```bash
nvim
```

On first launch, Mason will automatically install:
- `ts_ls` (TypeScript/JavaScript language server)
- `lua_ls` (Lua language server)

You'll see installation progress in the bottom right. **Wait for it to complete** (about 30 seconds).

### Step 2: Open the Test File
```vim
:e test.ts
```

You should see a notification: **"LSP attached: ts_ls"**

If you don't see it, the server might still be installing. Check with:
```vim
:Mason
```
Look for ✓ next to `typescript-language-server` and `lua-language-server`.

### Step 3: Test LSP Features

#### Test 1: Hover Documentation
1. Move cursor to the word `greeting` (line 7)
2. Press `K`
3. **Expected**: Popup showing `const greeting: string`

#### Test 2: Go to Definition
1. Move cursor to `greeting` on line 9
2. Press `gd`
3. **Expected**: Cursor jumps to line 7 where `greeting` is defined

#### Test 3: Show References
1. Move cursor to `greeting` on line 7
2. Press `gr`
3. **Expected**: List of all places where `greeting` is used

#### Test 4: Rename Symbol
1. Move cursor to `greeting` on line 7
2. Press `<Space>rn`
3. Type a new name (e.g., `message`)
4. Press Enter
5. **Expected**: All occurrences of `greeting` renamed to `message`

#### Test 5: Diagnostics (Error Detection)
1. Uncomment line 16: `const error: number = "this should error";`
2. **Expected**: Red underline under the string
3. Press `<Space>d` to see error message
4. **Expected**: Popup showing "Type 'string' is not assignable to type 'number'"

#### Test 6: Code Actions
1. Keep the error from Test 5
2. Move cursor to the error
3. Press `<Space>ca`
4. **Expected**: List of possible fixes

#### Test 7: Format File
1. Mess up the indentation in test.ts
2. Press `<Space>f`
3. **Expected**: File is automatically formatted

## 📊 Checking LSP Status

### Check Active LSP Clients
```vim
:LspInfo
```
**Expected output:**
```
 Language client log: /home/user/.local/state/nvim/lsp.log
 Detected filetype:   typescript
 
 1 client(s) attached to this buffer: 
 
 Client: ts_ls (id: 1, bufnr: [1])
 	filetypes:       typescript, typescriptreact, javascript, javascriptreact
 	autostart:       true
 	root directory:  /home/user/.config/nvim
 	cmd:             typescript-language-server --stdio
```

### Check Installed Servers
```vim
:Mason
```
**Expected**: See ✓ icons next to:
- `typescript-language-server`
- `lua-language-server`

### Check Mason Health
```vim
:checkhealth mason
```
**Expected**: All checks should be OK

## 🎯 Visual Indicators

When LSP is working, you should see:

1. **Notification on file open**: "LSP attached: ts_ls"
2. **Hover works**: `K` shows documentation popup
3. **Diagnostics appear**: Red underlines for errors
4. **Autocompletion**: Type `console.` and see suggestions (if you have completion plugin)
5. **Status line**: Some status lines show LSP status (optional)

## ⚠️ Troubleshooting

### No "LSP attached" notification
**Cause**: Server still installing or not installed
**Fix**: 
```vim
:Mason
```
Check if `typescript-language-server` has ✓. If not, press `i` to install.

### "LSP attached" but features don't work
**Cause**: Server crashed or root directory not detected
**Fix**:
```vim
:LspInfo
```
Check if client is attached. If not, restart Neovim.

### Hover shows nothing
**Cause**: Cursor not on a valid symbol
**Fix**: Make sure cursor is on a variable/function name, not whitespace.

### No error underlines
**Cause**: Diagnostics might be disabled
**Fix**: Check diagnostic config in `lua/user/lsp/init.lua`

### Server keeps crashing
**Cause**: Corrupted installation
**Fix**:
```vim
:Mason
:MasonUninstall typescript-language-server
:MasonInstall typescript-language-server
```

## 🎨 LSP Keymaps Reference

| Keymap | Action | Description |
|--------|--------|-------------|
| `K` | Hover | Show documentation |
| `gd` | Go to definition | Jump to where symbol is defined |
| `gD` | Go to declaration | Jump to declaration |
| `gi` | Go to implementation | Jump to implementation |
| `gr` | Show references | List all references |
| `<Space>rn` | Rename | Rename symbol |
| `<Space>ca` | Code action | Show available code actions |
| `<Space>f` | Format | Format current file |
| `[d` | Previous diagnostic | Go to previous error/warning |
| `]d` | Next diagnostic | Go to next error/warning |
| `<Space>d` | Show diagnostic | Show error/warning details |
| `<Space>m` | Open Mason | Open Mason UI |

## 🌟 Success Indicators

✅ **LSP is working if:**
- You see "LSP attached" notification
- `:LspInfo` shows attached client
- `K` on a symbol shows documentation
- Errors show red underlines
- `gd` jumps to definitions

❌ **LSP is NOT working if:**
- No notification on file open
- `:LspInfo` shows "0 clients attached"
- `K` does nothing
- No error detection
- `:Mason` shows ✗ next to servers

## 🚀 Next Steps

Once LSP is working:

1. **Add more languages**: Open `:Mason`, install servers for Python, Rust, Go, etc.
2. **Customize keymaps**: Edit `lua/user/lsp/init.lua` `on_attach` function
3. **Add completion**: Install `nvim-cmp` for autocompletion
4. **Add formatters**: Install formatters via Mason (prettier, black, etc.)

Enjoy your fully automatic LSP setup! 🎉


# Treesitter Guide

Treesitter provides **enhanced syntax highlighting**, **smart text objects**, and **code navigation** for your Neovim configuration.

## ✨ Features Enabled

### 1. **Enhanced Syntax Highlighting**
- More accurate than regex-based highlighting
- Understands code structure
- Better color differentiation
- Works for 12+ languages out of the box

### 2. **Incremental Selection**
- Press `<CR>` to expand selection to next syntax node
- Press `<S-CR>` to expand to scope
- Press `<BS>` to shrink selection

### 3. **Smart Text Objects**
- `af` / `if` - Select outer/inner function
- `ac` / `ic` - Select outer/inner class
- `aa` / `ia` - Select outer/inner parameter

### 4. **Code Navigation**
- `]f` / `[f` - Jump to next/previous function start
- `]F` / `[F` - Jump to next/previous function end
- `]c` / `[c` - Jump to next/previous class start
- `]C` / `[C` - Jump to next/previous class end

### 5. **Smart Indentation**
- Treesitter-based indentation
- More accurate than traditional indent rules

### 6. **Code Folding**
- Fold based on syntax structure
- `za` - Toggle fold
- `zR` - Open all folds
- `zM` - Close all folds

## 📦 Installed Language Parsers

Automatically installed on first launch:

| Language | Parser | Status |
|----------|--------|--------|
| TypeScript | `typescript` | ✅ Auto-install |
| JavaScript | `javascript` | ✅ Auto-install |
| TSX | `tsx` | ✅ Auto-install |
| JSON | `json` | ✅ Auto-install |
| JSONC | `jsonc` | ✅ Auto-install |
| Lua | `lua` | ✅ Auto-install |
| Vim | `vim` | ✅ Auto-install |
| Vimdoc | `vimdoc` | ✅ Auto-install |
| Markdown | `markdown` | ✅ Auto-install |
| HTML | `html` | ✅ Auto-install |
| CSS | `css` | ✅ Auto-install |
| Bash | `bash` | ✅ Auto-install |
| Regex | `regex` | ✅ Auto-install |

## 🎯 Testing Treesitter

### Test 1: Syntax Highlighting

Open a TypeScript file:
```bash
nvim test.ts
```

You should see:
- Keywords in different colors
- Strings, numbers, functions clearly distinguished
- Better highlighting than basic vim syntax

### Test 2: Incremental Selection

1. Open `test.ts`
2. Place cursor inside a function
3. Press `<CR>` repeatedly
4. Watch selection expand: word → expression → statement → function → file

### Test 3: Text Objects

In `test.ts`:
1. Place cursor inside a function
2. Press `vif` (visual select inner function)
3. Function body should be selected
4. Press `vaf` (visual select outer function)
5. Entire function including declaration should be selected

### Test 4: Function Navigation

In `test.ts`:
1. Press `]f` to jump to next function
2. Press `[f` to jump to previous function
3. Works across the entire file!

### Test 5: Code Folding

1. Open a file with functions
2. Press `zM` to fold all
3. Press `zR` to unfold all
4. Press `za` to toggle current fold

## 🔧 Configuration

### Current Settings

```lua
-- In lua/user/plugins/init.lua
require('nvim-treesitter.configs').setup({
  ensure_installed = { ... },  -- Languages to auto-install
  auto_install = true,         -- Auto-install missing parsers
  highlight = { enable = true }, -- Syntax highlighting
  indent = { enable = true },   -- Smart indentation
  incremental_selection = { ... }, -- Expand/shrink selection
  textobjects = { ... },        -- Smart text objects
})
```

### Adding More Languages

Edit `lua/user/plugins/init.lua`:

```lua
ensure_installed = {
  'typescript', 'javascript', 'tsx', 'json', 'jsonc',
  'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline',
  'html', 'css', 'bash', 'regex',
  'python',    -- Add Python
  'rust',      -- Add Rust
  'go',        -- Add Go
  'c',         -- Add C
  'cpp',       -- Add C++
},
```

Restart Neovim and parsers will install automatically!

## ⚡ Performance Features

### Large File Handling
- Automatically disables highlighting for files > 100KB
- Prevents slowdown on large files
- Configurable threshold

### Lazy Loading
- Treesitter loads only when opening files
- Not loaded on startup
- Fast initial load time

## 🎨 Keymaps Reference

### Incremental Selection
| Keymap | Action |
|--------|--------|
| `<CR>` | Expand selection to next node |
| `<S-CR>` | Expand to scope |
| `<BS>` | Shrink selection |

### Text Objects (in visual/operator mode)
| Keymap | Action |
|--------|--------|
| `af` | Select outer function |
| `if` | Select inner function |
| `ac` | Select outer class |
| `ic` | Select inner class |
| `aa` | Select outer parameter |
| `ia` | Select inner parameter |

### Navigation
| Keymap | Action |
|--------|--------|
| `]f` | Next function start |
| `[f` | Previous function start |
| `]F` | Next function end |
| `[F` | Previous function end |
| `]c` | Next class start |
| `[c` | Previous class start |
| `]C` | Next class end |
| `[C` | Previous class end |

### Folding
| Keymap | Action |
|--------|--------|
| `za` | Toggle fold |
| `zc` | Close fold |
| `zo` | Open fold |
| `zM` | Close all folds |
| `zR` | Open all folds |

## 🔍 Checking Treesitter Status

### Check Installed Parsers
```vim
:TSInstallInfo
```
Shows all available parsers and installation status

### Check Highlighting
```vim
:TSHighlightCapturesUnderCursor
```
Shows what highlight groups are applied under cursor

### Check Module Status
```vim
:checkhealth nvim-treesitter
```
Verifies Treesitter is working correctly

## ⚠️ Troubleshooting

### Syntax highlighting not working
**Cause**: Parser not installed
**Fix**:
```vim
:TSInstall typescript
```

### "Parser not found" error
**Cause**: Parser installation failed
**Fix**:
```vim
:TSUpdate
```

### Highlighting looks wrong
**Cause**: Conflicting syntax files
**Fix**: Add to config:
```lua
additional_vim_regex_highlighting = false
```
(Already configured!)

### Slow on large files
**Cause**: File too large for Treesitter
**Fix**: Automatic! Disables for files > 100KB

### Text objects not working
**Cause**: `nvim-treesitter-textobjects` not installed
**Fix**: Already included as dependency!

## 🎯 Use Cases

### 1. Refactoring
- Use `vif` to select function body
- Use `]f` to navigate between functions
- Use incremental selection to expand/shrink

### 2. Code Review
- Use `]f`/`[f` to jump between functions
- Use folding to collapse unimportant sections
- Use highlighting to understand structure

### 3. Editing
- Use text objects for precise selections
- Use smart indentation for clean code
- Use incremental selection for quick edits

## 📚 Examples

### Example 1: Rename Function Body
```
1. Place cursor in function
2. Press 'vif' to select inner function
3. Press 'c' to change
4. Type new code
```

### Example 2: Navigate Large File
```
1. Press 'zM' to fold all functions
2. Use ']f' to jump between function headers
3. Press 'zo' to open function you want
```

### Example 3: Copy Function
```
1. Place cursor in function
2. Press 'vaf' to select outer function
3. Press 'y' to yank
4. Press 'p' to paste
```

## 🎉 Benefits

✅ **Better highlighting** - Understands code structure  
✅ **Smart selections** - Select exactly what you need  
✅ **Fast navigation** - Jump between functions/classes  
✅ **Code folding** - Collapse/expand by syntax  
✅ **Auto-install** - Parsers install automatically  
✅ **Performance** - Optimized for large files  

Enjoy your enhanced Treesitter setup! 🚀


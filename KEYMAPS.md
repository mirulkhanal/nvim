# Keymaps Reference

Complete guide to all keybindings in your Neovim configuration.

## 🎯 Leader Key

**Leader Key:** `<Space>`

Press `<Space>` to see all available keymaps in the which-key popup!

## 📋 Quick Reference

### Most Used Keymaps

| Keymap | Action | Category |
|--------|--------|----------|
| `<Space>w` | Save file | File |
| `<Space>q` | Quit | File |
| `<Space>e` | Toggle file explorer | Explorer |
| `<Space>f` | Format file | Code |
| `<Space>ca` | Code action | Code |
| `<Space>cr` | Rename symbol | Code |
| `gd` | Go to definition | LSP |
| `K` | Hover documentation | LSP |
| `<Ctrl-h/j/k/l>` | Navigate windows | Window |

## 🗂️ Complete Keymap List

### File Operations (`<leader>f`)

| Keymap | Action |
|--------|--------|
| `<Space>fn` | New file |
| `<Space>fs` | Save file |
| `<Space>fS` | Save all files |
| `<Space>fq` | Quit |
| `<Space>fQ` | Quit all |

### Buffer Operations (`<leader>b`)

| Keymap | Action |
|--------|--------|
| `<Space>bd` | Delete buffer |
| `<Space>bD` | Force delete buffer |
| `<Space>bn` | Next buffer |
| `<Space>bp` | Previous buffer |
| `<Space>bl` | List buffers |

### Window/Split Operations (`<leader>s`)

| Keymap | Action |
|--------|--------|
| `<Space>sv` | Vertical split |
| `<Space>sh` | Horizontal split |
| `<Space>se` | Equal splits |
| `<Space>sx` | Close split |
| `<Space>sm` | Maximize split |
| `<Ctrl-h>` | Go to left window |
| `<Ctrl-j>` | Go to lower window |
| `<Ctrl-k>` | Go to upper window |
| `<Ctrl-l>` | Go to right window |

### Tab Operations (`<leader>t`)

| Keymap | Action |
|--------|--------|
| `<Space>tn` | New tab |
| `<Space>tc` | Close tab |
| `<Space>to` | Close other tabs |
| `<Space>tl` | Next tab |
| `<Space>th` | Previous tab |

### File Explorer (`<leader>e/o`)

| Keymap | Action |
|--------|--------|
| `<Space>e` | Toggle Neo-tree |
| `<Space>o` | Focus Neo-tree |

**Inside Neo-tree:**
| Keymap | Action |
|--------|--------|
| `<CR>` | Open file/folder |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `R` | Refresh |
| `?` | Show help |

### LSP Operations (`<leader>l`)

| Keymap | Action |
|--------|--------|
| `<Space>li` | LSP Info |
| `<Space>lr` | Restart LSP |
| `<Space>ls` | Start LSP |
| `<Space>lS` | Stop LSP |

### Code Operations (`<leader>c`)

| Keymap | Action |
|--------|--------|
| `<Space>ca` | Code action |
| `<Space>cr` | Rename symbol |
| `<Space>cf` | Format file |
| `<Space>cd` | Show diagnostic |
| `<Space>f` | Format file (quick) |

### LSP Navigation (No Leader)

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Show references |
| `K` | Hover documentation |
| `<Ctrl-k>` | Signature help |

### Diagnostics

| Keymap | Action |
|--------|--------|
| `<Space>d` | Show diagnostic float |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Treesitter Text Objects

**Selection (in visual mode):**
| Keymap | Action |
|--------|--------|
| `<CR>` | Expand selection to next node |
| `<Shift-CR>` | Expand to scope |
| `<BS>` | Shrink selection |

**Text Objects (use with `v`, `d`, `c`, etc.):**
| Keymap | Action |
|--------|--------|
| `af` | Select outer function |
| `if` | Select inner function |
| `ac` | Select outer class |
| `ic` | Select inner class |
| `aa` | Select outer parameter |
| `ia` | Select inner parameter |

**Navigation:**
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

### Treesitter Commands (`<leader>T`)

| Keymap | Action |
|--------|--------|
| `<Space>Ti` | Treesitter info |
| `<Space>Tu` | Update parsers |
| `<Space>Th` | Highlight info under cursor |

### Mason (`<leader>m`)

| Keymap | Action |
|--------|--------|
| `<Space>m` | Open Mason UI |

**Inside Mason:**
| Keymap | Action |
|--------|--------|
| `i` | Install package |
| `u` | Update package |
| `U` | Update all |
| `X` | Uninstall |
| `c` | Check version |
| `C` | Check outdated |

### Editing Helpers

| Keymap | Action |
|--------|--------|
| `<Esc>` | Clear search highlights |
| `<Space>h` | Clear highlights |
| `<Space>/` | Clear search |

**Visual Mode:**
| Keymap | Action |
|--------|--------|
| `<` | Indent left (stays in visual) |
| `>` | Indent right (stays in visual) |
| `p` | Paste without yanking |
| `<Alt-j>` | Move selection down |
| `<Alt-k>` | Move selection up |

**Normal Mode:**
| Keymap | Action |
|--------|--------|
| `<Alt-j>` | Move line down |
| `<Alt-k>` | Move line up |

### Help/Documentation (`<leader>?`)

| Keymap | Action |
|--------|--------|
| `<Space>?h` | Open help |
| `<Space>?k` | Show keymaps (Telescope) |
| `<Space>?c` | Check health |
| `<Space>?v` | Show version |

### Quick Actions (No Leader)

| Keymap | Action |
|--------|--------|
| `<Space>w` | Save file |
| `<Space>q` | Quit |
| `<Space>x` | Save and quit |

## 🎨 Code Folding

| Keymap | Action |
|--------|--------|
| `za` | Toggle fold |
| `zc` | Close fold |
| `zo` | Open fold |
| `zM` | Close all folds |
| `zR` | Open all folds |
| `zj` | Move to next fold |
| `zk` | Move to previous fold |

## 💡 Usage Examples

### Example 1: Refactor a Function
```
1. Place cursor on function name
2. Press 'gd' to go to definition
3. Press '<Space>cr' to rename
4. Type new name and press Enter
5. All references are updated!
```

### Example 2: Format and Save
```
1. Press '<Space>f' to format
2. Press '<Space>w' to save
Or: '<Space>x' to format, save, and quit
```

### Example 3: Navigate Code
```
1. Press 'gd' to go to definition
2. Press '<Ctrl-o>' to go back
3. Press 'gr' to see all references
4. Press 'K' to see documentation
```

### Example 4: Select Function Body
```
1. Place cursor in function
2. Press 'v' to enter visual mode
3. Press 'if' to select inner function
4. Press 'c' to change, 'd' to delete, 'y' to yank
```

### Example 5: Expand Selection
```
1. Place cursor in code
2. Press '<CR>' repeatedly
3. Selection expands: word → expression → statement → function
4. Press '<BS>' to shrink
```

### Example 6: Navigate Between Functions
```
1. Press ']f' to jump to next function
2. Press '[f' to jump to previous function
3. Press 'zM' to fold all functions
4. Press 'zo' to open current function
```

## 🔍 Finding Keymaps

### Method 1: Which-Key Popup
Press `<Space>` and wait - all keymaps will appear!

### Method 2: Search Keymaps
```vim
:Telescope keymaps
```
(If you install Telescope)

### Method 3: Check This File
Refer to this `KEYMAPS.md` file anytime!

### Method 4: In Neovim
```vim
:map <leader>
:map g
:map [
:map ]
```

## 🎯 Keymap Philosophy

### Organized by Prefix
- **`<Space>f`** - File operations
- **`<Space>b`** - Buffer operations
- **`<Space>s`** - Split/window operations
- **`<Space>t`** - Tab operations
- **`<Space>l`** - LSP operations
- **`<Space>c`** - Code operations
- **`<Space>T`** - Treesitter operations
- **`g`** - Go to (LSP navigation)
- **`[`/`]`** - Previous/Next navigation

### Mnemonic Design
- **`w`** = Write (save)
- **`q`** = Quit
- **`e`** = Explorer
- **`f`** = Format/File
- **`c`** = Code
- **`l`** = LSP
- **`d`** = Diagnostic
- **`r`** = Rename/Restart

## 🚀 Pro Tips

1. **Learn gradually** - Start with `<Space>w`, `<Space>e`, `gd`, `K`
2. **Use which-key** - Press `<Space>` and explore
3. **Practice text objects** - `vif`, `daf`, `cic` are powerful
4. **Use incremental selection** - `<CR>` to expand is magic
5. **Navigate with `]f`/`[f`** - Jump between functions quickly
6. **Format often** - `<Space>f` keeps code clean
7. **Fold strategically** - `zM` to collapse, `zo` to open

## 📝 Customization

To add your own keymaps, edit:
- `lua/user/core/keymaps.lua` - For general keymaps
- `lua/user/lsp/init.lua` - For LSP-specific keymaps

Example:
```lua
-- In lua/user/core/keymaps.lua
vim.keymap.set('n', '<leader>n', '<cmd>enew<CR>', { desc = 'New file' })
```

Happy coding! 🎉


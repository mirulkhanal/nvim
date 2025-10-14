# Telescope Guide - Fuzzy Finder with Live Preview

Telescope is your **Ctrl+P on steroids** - a powerful fuzzy finder with live preview, just like VSCode but better!

## 🚀 Quick Start

### Most Used Commands

| Keymap | Action | Description |
|--------|--------|-------------|
| `<Ctrl-p>` | Find files | Quick file finder (VSCode-style) |
| `<Space>ff` | Find files | Same as Ctrl+P |
| `<Space>fg` | Live grep | Search text in all files |
| `<Space>fb` | Find buffers | Switch between open buffers |
| `<Space>fr` | Recent files | Recently opened files |
| `<Space>fw` | Find word | Search word under cursor |

## 📋 All Telescope Commands

### File Operations (`<leader>f`)

| Keymap | Command | Description |
|--------|---------|-------------|
| `<Space>ff` | Find files | Fuzzy find files in project |
| `<Space>fg` | Live grep | Search text across all files |
| `<Space>fb` | Find buffers | List and switch buffers |
| `<Space>fh` | Help tags | Search Neovim help |
| `<Space>fr` | Recent files | Recently opened files |
| `<Space>fw` | Find word | Search word under cursor |
| `<Space>fc` | Commands | Search available commands |
| `<Space>fk` | Keymaps | Search all keymaps |
| `<Space>fs` | Document symbols | Find functions/classes in file |
| `<Space>fS` | Workspace symbols | Find symbols in workspace |

## 🎮 Navigation Inside Telescope

### Insert Mode (Default)

| Keymap | Action |
|--------|--------|
| `<Ctrl-j>` | Move down |
| `<Ctrl-k>` | Move up |
| `<Ctrl-q>` | Send to quickfix list |
| `<Enter>` | Open selected file |
| `<Esc>` | Close Telescope |
| Type to search | Fuzzy search |

### Normal Mode

| Keymap | Action |
|--------|--------|
| `j/k` | Move down/up |
| `gg/G` | Go to top/bottom |
| `q` | Close Telescope |
| `<Ctrl-q>` | Send to quickfix list |
| `<Enter>` | Open selected file |

### Buffer Picker Specific

| Keymap | Action |
|--------|--------|
| `<Ctrl-d>` | Delete buffer (insert mode) |
| `dd` | Delete buffer (normal mode) |

## 🎯 Features

### Live Preview
- **Real-time preview** - See file contents as you navigate
- **Syntax highlighting** - Treesitter-powered highlighting
- **Large preview window** - 55% of screen width
- **Smooth scrolling** - Preview updates instantly

### Fuzzy Finding
- **Smart matching** - Type any part of filename
- **Case insensitive** - Automatic smart case
- **Fast search** - FZF-powered native sorting
- **Ignore patterns** - Skips node_modules, .git, etc.

### Beautiful UI
- **Dropdown theme** - Clean, centered interface
- **Custom icons** - 🔍 for search, ➜ for selection
- **Large window** - 87% width, 80% height
- **Truncated paths** - Clean file path display

## 💡 Usage Examples

### Example 1: Quick File Search (Ctrl+P)
```
1. Press <Ctrl-p> or <Space>ff
2. Type part of filename: "init"
3. See preview on the right
4. Use <Ctrl-j>/<Ctrl-k> to navigate
5. Press <Enter> to open
```

### Example 2: Search Text in Files
```
1. Press <Space>fg
2. Type text to search: "function"
3. See all matches with preview
4. Navigate with <Ctrl-j>/<Ctrl-k>
5. Press <Enter> to jump to match
```

### Example 3: Find Function in File
```
1. Open a code file
2. Press <Space>fs
3. Type function name: "setup"
4. See all functions/classes
5. Press <Enter> to jump
```

### Example 4: Switch Buffers
```
1. Press <Space>fb
2. See all open buffers with preview
3. Use j/k to navigate (normal mode)
4. Press <Enter> to switch
5. Or press dd to delete buffer
```

### Example 5: Search Word Under Cursor
```
1. Place cursor on a word
2. Press <Space>fw
3. See all occurrences across project
4. Navigate and jump to any occurrence
```

### Example 6: Find Recent Files
```
1. Press <Space>fr
2. See recently opened files
3. Quick access to your work
4. Press <Enter> to reopen
```

## 🔍 Search Patterns

### File Search (`<Space>ff`)
```
init        → Matches: init.lua, init_config.lua
plug        → Matches: plugins.lua, plugin_manager.lua
user/core   → Matches: lua/user/core/options.lua
```

### Live Grep (`<Space>fg`)
```
function    → Finds all "function" in files
TODO        → Finds all TODO comments
vim.keymap  → Finds all keymap definitions
```

### Symbols (`<Space>fs`)
```
setup       → Finds all setup functions
Config      → Finds all Config classes
on_attach   → Finds on_attach function
```

## ⚙️ Configuration

### Ignored Patterns
Telescope automatically ignores:
- `node_modules/` - NPM packages
- `.git/` - Git directory
- `dist/` - Build output
- `build/` - Build directory
- `*.lock` - Lock files

### Layout
- **Width:** 87% of screen
- **Height:** 80% of screen
- **Preview:** 55% of Telescope width
- **Theme:** Dropdown (centered)

### Performance
- **FZF native** - Ultra-fast fuzzy matching
- **Lazy loading** - Only loads when used
- **Smart cache** - Remembers recent searches

## 🎨 Themes

Current theme: **Dropdown**
- Centered on screen
- Clean, minimal design
- Large preview window
- Easy to read

## 🔧 Advanced Features

### Send to Quickfix List
```
1. Search for something
2. Press <Ctrl-q>
3. All results go to quickfix
4. Navigate with :cnext/:cprev
```

### Multi-file Editing
```
1. Search with <Space>fg
2. Press <Ctrl-q> to send to quickfix
3. Use :cdo to edit all matches
4. Example: :cdo s/old/new/g
```

### Symbol Navigation
```
1. Press <Space>fs for current file
2. Press <Space>fS for entire workspace
3. Jump between functions/classes
4. Great for large codebases
```

## 📊 Comparison with VSCode Ctrl+P

| Feature | VSCode Ctrl+P | Telescope |
|---------|---------------|-----------|
| **File search** | ✅ | ✅ |
| **Live preview** | ❌ | ✅ |
| **Grep search** | Limited | ✅ Full |
| **Symbol search** | ✅ | ✅ |
| **Fuzzy matching** | ✅ | ✅ Better |
| **Customizable** | Limited | ✅ Full |
| **Speed** | Fast | ⚡ Faster |
| **UI** | Good | 🎨 Beautiful |

## 🚀 Pro Tips

1. **Use Ctrl+P** - Fastest way to find files
2. **Live grep is powerful** - Search entire codebase instantly
3. **Preview is your friend** - See before you open
4. **Use symbols** - Navigate large files easily
5. **Quickfix integration** - Batch edit multiple files
6. **Recent files** - Quick access to your work
7. **Buffer picker** - Manage open files efficiently

## 🎯 Workflow Examples

### Workflow 1: Navigate Large Project
```
1. <Ctrl-p> to find file
2. <Space>fs to find function
3. <Space>fg to search usage
4. <Space>fr to return to recent work
```

### Workflow 2: Refactoring
```
1. <Space>fw to find all usages
2. <Ctrl-q> to send to quickfix
3. :cdo s/old/new/g to replace all
4. :wa to save all files
```

### Workflow 3: Code Review
```
1. <Space>fg "TODO" to find todos
2. <Space>fg "FIXME" to find fixes
3. Navigate with preview
4. Fix issues one by one
```

## 📝 Customization

To customize Telescope, edit `lua/user/plugins/init.lua`:

```lua
-- Change theme
find_files = {
  theme = 'ivy',  -- or 'cursor', 'dropdown'
}

-- Add more ignore patterns
file_ignore_patterns = {
  'node_modules',
  '.git/',
  'your_pattern_here',
}

-- Adjust layout
layout_config = {
  width = 0.95,  -- Bigger window
  preview_width = 0.6,  -- Larger preview
}
```

## 🔍 Troubleshooting

### No preview showing
- Preview is enabled by default
- Check if file is too large
- Try resizing Neovim window

### Slow search
- FZF native should be installed
- Check `:checkhealth telescope`
- Reduce file_ignore_patterns

### Can't find files
- Check if in correct directory
- Hidden files are not shown by default
- Check ignore patterns

### Grep not working
- Requires `ripgrep` installed
- Install: `sudo dnf install ripgrep` (Fedora)
- Or: `sudo apt install ripgrep` (Ubuntu)

## 🎉 Benefits

✅ **VSCode-like experience** - Familiar Ctrl+P workflow  
✅ **Live preview** - See files before opening  
✅ **Blazing fast** - FZF-powered search  
✅ **Beautiful UI** - Clean, modern interface  
✅ **Powerful grep** - Search entire codebase  
✅ **Symbol navigation** - Find functions/classes  
✅ **Highly customizable** - Tweak everything  
✅ **Well integrated** - Works with LSP, Treesitter  

Enjoy your powerful fuzzy finder! 🚀


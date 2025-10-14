# VSCode-Like Features Guide

This document covers all the VSCode-like features added to your Neovim configuration for a familiar and productive workflow.

## 📋 Table of Contents

1. [Autopairs](#autopairs)
2. [Auto Tag Closing](#auto-tag-closing)
3. [Multi-Cursor Editing](#multi-cursor-editing)
4. [Surround](#surround)
5. [Indent Guides](#indent-guides)
6. [Auto-Imports](#auto-imports)
7. [VSCode-like Settings](#vscode-like-settings)

---

## 1. Autopairs

**Plugin:** `nvim-autopairs`  
**Purpose:** Automatically closes brackets, quotes, and parentheses

### Features

✅ Auto-close brackets: `(`, `[`, `{`  
✅ Auto-close quotes: `"`, `'`, `` ` ``  
✅ Smart deletion: Delete opening and closing together  
✅ Treesitter integration: Context-aware pairing  
✅ Fast wrap: Quickly wrap text with brackets  

### Usage

#### Basic Auto-closing
```typescript
// Type: (
// Result: (|)  // cursor in middle

// Type: "hello
// Result: "hello"|  // cursor after closing quote
```

#### Fast Wrap
```typescript
// Cursor on word: hello
// Press Alt+e, then type (
// Result: (hello)
```

**Fast Wrap Keymap:** `Alt+e` then bracket character

### Examples

```typescript
// Auto-close function parentheses
function test(|)  // Type ( and ) appears

// Auto-close object braces
const obj = {|}  // Type { and } appears

// Auto-close array brackets
const arr = [|]  // Type [ and ] appears

// Auto-close strings
const str = "|"  // Type " and closing " appears
```

### Configuration

- **Treesitter-aware:** Won't add pairs inside strings
- **Disabled in:** Telescope, Vim command mode
- **Fast wrap chars:** `{`, `[`, `(`, `"`, `'`

---

## 2. Auto Tag Closing

**Plugin:** `nvim-ts-autotag`  
**Purpose:** Automatically closes and renames HTML/JSX tags

### Features

✅ Auto-close tags: `<div>` → `<div></div>`  
✅ Auto-rename tags: Change `<div>` to `<span>`, closing tag updates  
✅ Close on slash: Type `</` and tag name appears  
✅ Works in: HTML, JSX, TSX, Vue, Svelte  

### Usage

#### Auto-close Tags
```html
<!-- Type: <div> -->
<div>|</div>  <!-- Closing tag appears -->

<!-- Type: <button> -->
<button>|</button>
```

#### Auto-rename Tags
```html
<!-- Change opening tag -->
<div>content</div>

<!-- Edit to: -->
<span>content</span>  <!-- Closing tag updates automatically! -->
```

#### Close on Slash
```html
<div>
  <p>Hello</p>
  <!-- Type: </ -->
  <!-- Auto-completes to: </div> -->
</div>
```

### Supported File Types

- HTML (`.html`)
- JSX (`.jsx`)
- TSX (`.tsx`)
- Vue (`.vue`)
- Svelte (`.svelte`)
- XML (`.xml`)

---

## 3. Multi-Cursor Editing

**Plugin:** `vim-visual-multi`  
**Purpose:** Edit multiple locations simultaneously (like VSCode Ctrl+D)

### Features

✅ **Ctrl+D:** Select next occurrence (like VSCode)  
✅ **Ctrl+Down/Up:** Add cursor above/below  
✅ **Ctrl+X:** Skip current occurrence  
✅ Multiple cursors: Edit many places at once  

### Keymaps

| Keymap | Action |
|--------|--------|
| `<Ctrl-d>` | Select next occurrence of word under cursor |
| `<Ctrl-Down>` | Add cursor below |
| `<Ctrl-Up>` | Add cursor above |
| `<Ctrl-x>` | Skip current occurrence |
| `<Ctrl-p>` | Remove current cursor |
| `n` | Go to next cursor (in multi-cursor mode) |
| `N` | Go to previous cursor |
| `q` | Skip and go to next |
| `Q` | Remove cursor and go to previous |
| `<Tab>` | Switch between cursor and extend mode |
| `<Esc>` | Exit multi-cursor mode |

### Usage Examples

#### Example 1: Rename All Occurrences
```typescript
const name = "John";
console.log(name);  // Cursor on "name"
alert(name);

// Press Ctrl+d three times to select all "name"
// Type new name: "user"

const user = "John";
console.log(user);
alert(user);
```

#### Example 2: Edit Multiple Lines
```typescript
const a = 1;  // Press Ctrl+Down twice
const b = 2;  // to add cursors here
const c = 3;  // and here

// Now type at all three locations simultaneously
// Add "let " before each
let const a = 1;
let const b = 2;
let const c = 3;
```

#### Example 3: Skip Occurrences
```typescript
const test = "hello";
const test = "world";  // Want to change this
const test = "foo";    // and this
const test = "bar";    // but not this

// Cursor on first "test"
// Ctrl+d (selects first)
// Ctrl+x (skips first)
// Ctrl+d (selects second)
// Ctrl+d (selects third)
// Ctrl+x (skips fourth)
// Now edit selected occurrences
```

### Workflow

1. **Start:** Place cursor on word, press `Ctrl+d`
2. **Select more:** Keep pressing `Ctrl+d` to select more occurrences
3. **Skip:** Press `Ctrl+x` to skip unwanted occurrences
4. **Edit:** Type to edit all selected locations
5. **Exit:** Press `Esc` when done

---

## 4. Surround

**Plugin:** `nvim-surround`  
**Purpose:** Add, change, delete surrounding characters

### Features

✅ Add surrounds: Wrap text with brackets, quotes, tags  
✅ Change surrounds: Change `"` to `'` or `(` to `[`  
✅ Delete surrounds: Remove brackets, quotes  
✅ Works with: Brackets, quotes, tags, custom characters  

### Keymaps

| Keymap | Action | Example |
|--------|--------|---------|
| `ys{motion}{char}` | Add surround | `ysiw"` → surround word with `"` |
| `yss{char}` | Surround entire line | `yss(` → `(line)` |
| `S{char}` | Surround visual selection | Select text, `S"` |
| `ds{char}` | Delete surround | `ds"` → remove `"` |
| `cs{old}{new}` | Change surround | `cs"'` → change `"` to `'` |

### Usage Examples

#### Add Surrounds
```typescript
// Cursor on "hello"
hello world

// Press: ysiw"
"hello" world

// Press: ysiw)
("hello") world
```

#### Change Surrounds
```typescript
"hello world"

// Press: cs"'
'hello world'

// Press: cs'(
( hello world )

// Press: cs(]
[ hello world ]
```

#### Delete Surrounds
```typescript
"hello world"

// Press: ds"
hello world

(test)

// Press: ds(
test
```

#### Surround Visual Selection
```typescript
hello world

// Select "hello world" in visual mode
// Press: S"
"hello world"

// Select text, Press: S<div>
<div>hello world</div>
```

#### Surround Entire Line
```typescript
console.log("test");

// Press: yss(
(console.log("test");)
```

### Common Patterns

```
ysiw"  - Surround word with "
ysiw'  - Surround word with '
ysiw(  - Surround word with ( )
ysiw[  - Surround word with [ ]
ysiw{  - Surround word with { }
yss"   - Surround line with "
ds"    - Delete " surrounds
cs"'   - Change " to '
cs({   - Change ( ) to { }
```

---

## 5. Indent Guides

**Plugin:** `indent-blankline.nvim`  
**Purpose:** Show vertical lines for indentation levels

### Features

✅ Visual indent guides  
✅ Highlight current scope  
✅ Treesitter integration  
✅ Clean, minimal design  

### Appearance

```typescript
function test() {
▏ if (true) {
▏ ▏ console.log("hello");
▏ ▏ if (nested) {
▏ ▏ ▏ doSomething();
▏ ▏ }
▏ }
}
```

### Configuration

- **Character:** `▏` (thin vertical line)
- **Scope highlighting:** Shows current block
- **Disabled in:** Help, Neo-tree, Mason, Dashboard

### Benefits

✅ **Visual clarity:** See code structure at a glance  
✅ **Scope awareness:** Know which block you're in  
✅ **Nested code:** Easier to read deeply nested code  
✅ **Professional look:** Clean, modern appearance  

---

## 6. Auto-Imports

**Feature:** LSP Code Actions  
**Purpose:** Automatically import missing modules/types

### Keymaps

| Keymap | Mode | Action |
|--------|------|--------|
| `<Ctrl-Space>` | Normal | Show code actions (auto-import) |
| `<Ctrl-Space>` | Insert | Show signature help |
| `<leader>ca` | Normal | Show code actions |
| `<leader>ca` | Visual | Show code actions for selection |

### Usage

#### Auto-import Missing Module
```typescript
// Type this without importing:
const result = useState(0);
//             ^^^^^^^^ - Error: 'useState' is not defined

// Cursor on "useState"
// Press: Ctrl+Space
// Select: "Import useState from 'react'"
// Result:
import { useState } from 'react';
const result = useState(0);
```

#### Auto-import Type
```typescript
// Type this:
const user: User = { name: "John" };
//          ^^^^ - Error: Cannot find name 'User'

// Cursor on "User"
// Press: Ctrl+Space
// Select: "Import User from './types'"
// Result:
import { User } from './types';
const user: User = { name: "John" };
```

#### Organize Imports
```typescript
// Messy imports:
import { b } from './b';
import { a } from './a';
import { c } from './c';

// Press: <leader>ca
// Select: "Organize imports"
// Result:
import { a } from './a';
import { b } from './b';
import { c } from './c';
```

### Available Code Actions

- **Add missing import** - Import undefined symbols
- **Add all missing imports** - Import all undefined at once
- **Organize imports** - Sort and clean imports
- **Remove unused imports** - Clean up unused imports
- **Fix all fixable errors** - Auto-fix simple errors
- **Add type annotation** - Add missing types

### Workflow

1. **Write code** without imports
2. **See error** on undefined symbol
3. **Press** `Ctrl+Space` on the symbol
4. **Select** the import action
5. **Done!** Import added automatically

---

## 7. VSCode-like Settings

### Editor Behavior

```lua
-- Indentation (2 spaces like VSCode default)
vim.o.expandtab = true        -- Use spaces, not tabs
vim.o.shiftwidth = 2          -- Indent size: 2 spaces
vim.o.tabstop = 2             -- Tab displays as 2 spaces
vim.o.softtabstop = 2         -- Editing uses 2 spaces
vim.o.smartindent = true      -- Smart auto-indenting
vim.o.autoindent = true       -- Copy indent from current line
```

### File Handling

```lua
-- Persistent undo (like VSCode)
vim.o.undofile = true         -- Save undo history to file
vim.o.undolevels = 10000      -- 10,000 undo levels

-- No swap/backup files (like VSCode)
vim.o.swapfile = false        -- No .swp files
vim.o.backup = false          -- No backup files
vim.o.writebackup = false     -- No backup before overwrite
```

### Display

```lua
-- Line wrapping
vim.o.wrap = false            -- Don't wrap lines (like VSCode)
vim.o.linebreak = true        -- Break at word boundaries
vim.o.breakindent = true      -- Maintain indent when wrapping

-- Cursor and scrolling
vim.o.cursorline = true       -- Highlight current line
vim.o.scrolloff = 10          -- Keep 10 lines visible above/below cursor
```

### Comparison with VSCode

| Feature | VSCode | Neovim (This Config) |
|---------|--------|---------------------|
| **Indent size** | 2 spaces | ✅ 2 spaces |
| **Use spaces** | Yes | ✅ Yes |
| **Persistent undo** | Yes | ✅ Yes (10,000 levels) |
| **No swap files** | Yes | ✅ Yes |
| **Line wrap** | Off | ✅ Off |
| **Cursor line** | Highlight | ✅ Highlight |
| **Scroll offset** | None | ✅ 10 lines |

---

## 🎯 Quick Reference

### Most Used Features

| Feature | Keymap | Description |
|---------|--------|-------------|
| **Multi-cursor** | `Ctrl+d` | Select next occurrence |
| **Auto-import** | `Ctrl+Space` | Import missing module |
| **Surround word** | `ysiw"` | Wrap word with quotes |
| **Change surround** | `cs"'` | Change quotes type |
| **Delete surround** | `ds"` | Remove quotes |
| **Fast wrap** | `Alt+e` | Quick bracket wrapping |

### Auto-features

✅ **Auto-close brackets** - Type `(` get `()`  
✅ **Auto-close tags** - Type `<div>` get `<div></div>`  
✅ **Auto-rename tags** - Change `<div>` updates `</div>`  
✅ **Auto-import** - `Ctrl+Space` on undefined symbol  
✅ **Auto-indent** - Smart indentation on new line  
✅ **Indent guides** - Visual indentation lines  

---

## 🚀 Workflow Examples

### Example 1: React Component
```tsx
// 1. Type component without imports
function MyComponent() {
  const [count, setCount] = useState(0);
  //                        ^^^^^^^^ undefined
  
  // 2. Ctrl+Space on useState
  // 3. Select "Import useState from 'react'"
  // 4. Import added automatically!
  
  return (
    // 5. Type <div> - auto-closes to <div></div>
    <div>
      // 6. Type <button> - auto-closes
      <button onClick={() => setCount(count + 1)}>
        Count: {count}
      </button>
    </div>
  );
}
```

### Example 2: Multi-cursor Refactor
```typescript
// Change all "user" to "customer"
const user = getUser();
console.log(user.name);
alert(user.email);

// 1. Cursor on first "user"
// 2. Ctrl+d, Ctrl+d, Ctrl+d (select all)
// 3. Type "customer"
// 4. Done!

const customer = getUser();
console.log(customer.name);
alert(customer.email);
```

### Example 3: Surround Refactor
```typescript
// Wrap expression in parentheses
const result = a + b * c;

// 1. Cursor on "b * c"
// 2. vi* (select inside multiplication)
// 3. S( (surround with parentheses)

const result = a + (b * c);
```

---

## 📝 Summary of Changes

### Plugins Added

1. **nvim-autopairs** - Auto-close brackets and quotes
2. **nvim-ts-autotag** - Auto-close HTML/JSX tags
3. **vim-visual-multi** - Multi-cursor editing
4. **nvim-surround** - Surround text with brackets/quotes
5. **indent-blankline** - Visual indent guides

### Settings Changed

- **Indentation:** 2 spaces (VSCode default)
- **Undo:** Persistent with 10,000 levels
- **Files:** No swap/backup files
- **Wrapping:** Disabled by default
- **Smart indent:** Enabled

### Keymaps Added

- **Ctrl+d** - Multi-cursor select
- **Ctrl+Space** - Auto-import/code actions
- **Alt+e** - Fast wrap
- **ys/cs/ds** - Surround operations
- **Ctrl+Down/Up** - Add cursors

---

## 🎉 Benefits

✅ **Familiar workflow** - Works like VSCode  
✅ **Faster editing** - Auto-pairs, multi-cursor, surround  
✅ **Better imports** - Auto-import with Ctrl+Space  
✅ **Visual clarity** - Indent guides, cursor line  
✅ **Smart editing** - Context-aware features  
✅ **No overhead** - Lightweight, fast plugins  

Your Neovim now feels like VSCode but faster! 🚀


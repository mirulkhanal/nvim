# Colorscheme Guide - Gruvbox Material

Your Neovim is configured with **Gruvbox Material Dark Hard** - a beautiful, eye-friendly colorscheme!

## 🎨 Current Configuration

**Active Theme:** Gruvbox Material  
**Variant:** Dark Hard  
**Palette:** Material  
**Features:** Bold & Italic enabled

## ⚙️ Settings

```lua
-- In lua/user/plugins/init.lua
vim.g.gruvbox_material_background = 'hard'        -- Contrast level
vim.g.gruvbox_material_foreground = 'material'    -- Color palette
vim.g.gruvbox_material_enable_italic = true       -- Enable italics
vim.g.gruvbox_material_enable_bold = true         -- Enable bold
vim.g.gruvbox_material_transparent_background = 0 -- Opaque background
vim.g.gruvbox_material_better_performance = 1     -- Performance optimization
```

## 🎯 Available Variants

### Background (Contrast)
Edit `vim.g.gruvbox_material_background`:

| Value | Description | Contrast |
|-------|-------------|----------|
| `'hard'` | **Current** - Highest contrast | ⬛⬜⬜ |
| `'medium'` | Balanced contrast | ⬛⬛⬜ |
| `'soft'` | Lowest contrast (softest on eyes) | ⬛⬛⬛ |

### Foreground (Palette)
Edit `vim.g.gruvbox_material_foreground`:

| Value | Description |
|-------|-------------|
| `'material'` | **Current** - Carefully designed soft contrast |
| `'mix'` | Mean of material and original |
| `'original'` | Original Gruvbox colors |

### Background Transparency
Edit `vim.g.gruvbox_material_transparent_background`:

| Value | Description |
|-------|-------------|
| `0` | **Current** - Opaque (solid background) |
| `1` | Transparent background |
| `2` | Transparent background + UI elements |

## 🔄 Switching Variants

### To Medium Contrast:
```lua
-- Edit lua/user/plugins/init.lua
vim.g.gruvbox_material_background = 'medium'
```

### To Soft Contrast:
```lua
-- Edit lua/user/plugins/init.lua
vim.g.gruvbox_material_background = 'soft'
```

### To Original Gruvbox Colors:
```lua
-- Edit lua/user/plugins/init.lua
vim.g.gruvbox_material_foreground = 'original'
```

### To Transparent Background:
```lua
-- Edit lua/user/plugins/init.lua
vim.g.gruvbox_material_transparent_background = 1
```

After editing, restart Neovim or run `:source $MYVIMRC`

## 🎨 Color Palette (Dark Hard Material)

### Main Colors
- **Background:** `#1d2021` (Very dark gray-brown)
- **Foreground:** `#d4be98` (Warm beige)
- **Red:** `#ea6962` (Soft red)
- **Green:** `#a9b665` (Muted green)
- **Yellow:** `#d8a657` (Warm yellow)
- **Blue:** `#7daea3` (Soft blue)
- **Purple:** `#d3869b` (Muted purple)
- **Aqua:** `#89b482` (Soft cyan)
- **Orange:** `#e78a4e` (Warm orange)

### UI Colors
- **Cursor Line:** Subtle highlight
- **Selection:** Blue-gray tint
- **Comments:** Gray-brown (italic if enabled)
- **Strings:** Green
- **Keywords:** Red
- **Functions:** Yellow

## ✨ Features

✅ **Eye Protection** - Carefully designed soft contrast  
✅ **Treesitter Support** - Enhanced syntax highlighting  
✅ **LSP Support** - Proper diagnostic colors  
✅ **Plugin Integration** - Works with Neo-tree, Which-key, etc.  
✅ **Italic Support** - Beautiful italic comments and keywords  
✅ **Performance** - Optimized for speed  

## 🧪 Testing the Theme

### Visual Check
1. Open Neovim: `nvim`
2. Check the background is dark with warm tones
3. Open a code file: `:e test.ts`
4. Verify syntax highlighting is colorful and easy on eyes

### Check Active Theme
```vim
:echo g:colors_name
" Should output: gruvbox-material
```

### Check Settings
```vim
:echo g:gruvbox_material_background
" Should output: hard

:echo g:gruvbox_material_foreground
" Should output: material
```

## 🎯 Comparison with Other Variants

### Hard vs Medium vs Soft

| Feature | Hard | Medium | Soft |
|---------|------|--------|------|
| **Contrast** | Highest | Balanced | Lowest |
| **Eye Strain** | More | Moderate | Less |
| **Readability** | Best | Good | Good |
| **Long Sessions** | OK | Better | Best |
| **Outdoor Use** | Best | Good | Harder |

**Current:** Hard - Great for readability and outdoor use

### Material vs Mix vs Original

| Palette | Description | Best For |
|---------|-------------|----------|
| **Material** | Softest, most modern | Long coding sessions |
| **Mix** | Balanced | General use |
| **Original** | Classic Gruvbox | Gruvbox purists |

**Current:** Material - Best for eye protection

## 🔧 Customization Examples

### Example 1: Softest Setup (Best for Eyes)
```lua
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_transparent_background = 0
```

### Example 2: Classic Gruvbox Feel
```lua
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_transparent_background = 0
```

### Example 3: Transparent for Terminal
```lua
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_transparent_background = 1
```

### Example 4: Maximum Performance
```lua
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_italic = false -- Disable for speed
```

## 🌈 Switching to Other Colorschemes

If you want to try other colorschemes:

### Option 1: Temporary Switch
```vim
:colorscheme default
:colorscheme habamax
:colorscheme slate
```

### Option 2: Permanent Switch
Edit `lua/user/plugins/init.lua` and change the colorscheme plugin:

```lua
-- Replace gruvbox-material with another theme
{
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('tokyonight')
  end,
},
```

Popular alternatives:
- `folke/tokyonight.nvim` - Modern, vibrant
- `catppuccin/nvim` - Pastel, soothing
- `rebelot/kanagawa.nvim` - Dark, inspired by Japanese art
- `EdenEast/nightfox.nvim` - Multiple variants
- `sainnhe/everforest` - Green, forest theme

## 📚 Documentation

Full documentation: `:help gruvbox-material`

Key help topics:
- `:help gruvbox-material-configuration` - All settings
- `:help gruvbox-material-faq` - Common questions
- `:help gruvbox-material-usage` - Usage examples

## 🎉 Benefits

✅ **Professional Look** - Clean, modern appearance  
✅ **Eye Comfort** - Reduced strain during long sessions  
✅ **Consistency** - Works across all file types  
✅ **Performance** - Fast and optimized  
✅ **Customizable** - Easy to adjust to your preference  
✅ **Well Maintained** - Active development and support  

Enjoy your beautiful Gruvbox Material theme! 🎨


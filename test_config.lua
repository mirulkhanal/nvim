-- Test script to verify Neovim configuration
print("=== Neovim Configuration Test ===")

-- Test 1: Check if core modules load
print("1. Testing core modules...")
local success, err = pcall(require, 'user.core.options')
if success then
  print("   ✓ options.lua loaded successfully")
else
  print("   ✗ Failed to load options.lua:", err)
end

local success, err = pcall(require, 'user.core.keymaps')
if success then
  print("   ✓ keymaps.lua loaded successfully")
else
  print("   ✗ Failed to load keymaps.lua:", err)
end

-- Test 2: Check leader key
print("2. Testing leader key...")
print("   Leader key:", "'" .. vim.g.mapleader .. "'")
print("   Leader length:", string.len(vim.g.mapleader))

-- Test 3: Check plugins
print("3. Testing plugin loading...")
local success, err = pcall(require, 'lazy')
if success then
  print("   ✓ lazy.nvim loaded successfully")
else
  print("   ✗ Failed to load lazy.nvim:", err)
end

-- Test 4: Check which-key
print("4. Testing which-key...")
local success, wk = pcall(require, 'which-key')
if success then
  print("   ✓ which-key loaded successfully")
  print("   Which-key setup function:", type(wk.setup))
else
  print("   ✗ Failed to load which-key:", wk)
end

-- Test 5: Check keymaps
print("5. Testing keymap registration...")
local keymaps = vim.api.nvim_get_keymap('n')
local leader_keymaps = {}
for k, v in pairs(keymaps) do
  if string.find(k, '<leader>') then
    table.insert(leader_keymaps, k)
  end
end

if #leader_keymaps > 0 then
  print("   ✓ Found " .. #leader_keymaps .. " leader keymaps:")
  for _, keymap in ipairs(leader_keymaps) do
    print("     -", keymap)
  end
else
  print("   ✗ No leader keymaps found")
end

print("=== Test Complete ===")

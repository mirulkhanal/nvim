-- Test script to verify configuration in interactive mode
print("=== Interactive Configuration Test ===")

-- Test basic functionality
print("1. Testing basic setup...")
print("   Leader key:", "'" .. vim.g.mapleader .. "'")
print("   Leader length:", string.len(vim.g.mapleader))

-- Test which-key
local success, wk = pcall(require, 'which-key')
if success then
  print("   ✓ which-key loaded successfully")
else
  print("   ✗ Failed to load which-key:", wk)
end

-- Test keymaps
local keymaps = vim.api.nvim_get_keymap('n')
local leader_keymaps = {}
for k, v in pairs(keymaps) do
  if string.find(k, '<leader>') then
    table.insert(leader_keymaps, k)
  end
end

print("2. Found " .. #leader_keymaps .. " leader keymaps")
for _, keymap in ipairs(leader_keymaps) do
  print("   -", keymap)
end

print("3. Instructions:")
print("   - Press <space> to test which-key")
print("   - Press <leader>w to save (should work)")
print("   - Press <leader>e to toggle explorer")
print("   - Type :q to quit")

print("=== Test Complete ===")

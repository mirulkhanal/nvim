-- Custom highlights for enhanced Neo-tree appearance
-- This removes the drab tildes and adds vibrant colors

-- Neo-tree specific highlights
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', fg = '#abb2bf' })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', fg = '#abb2bf' })
vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'NONE', fg = '#1e1e2e' })
vim.api.nvim_set_hl(0, 'NeoTreeRootName', { fg = '#89b4fa', bold = true })
vim.api.nvim_set_hl(0, 'NeoTreeFileName', { fg = '#cdd6f4' })
vim.api.nvim_set_hl(0, 'NeoTreeFileNameOpened', { fg = '#f5e0dc', bold = true })
vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', { fg = '#313244' })
vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = '#a6e3a1' })
vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = '#f38ba8' })
vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = '#f38ba8' })
vim.api.nvim_set_hl(0, 'NeoTreeGitIgnored', { fg = '#6c7086' })
vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#fab387' })
vim.api.nvim_set_hl(0, 'NeoTreeGitRenamed', { fg = '#f9e2af' })
vim.api.nvim_set_hl(0, 'NeoTreeGitStaged', { fg = '#a6e3a1' })
vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#f9e2af' })
vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged', { fg = '#fab387' })
vim.api.nvim_set_hl(0, 'NeoTreeExpander', { fg = '#89b4fa' })
vim.api.nvim_set_hl(0, 'NeoTreeModified', { fg = '#fab387' })
vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#89b4fa' })
vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#89b4fa' })
vim.api.nvim_set_hl(0, 'NeoTreeSymbolicLinkTarget', { fg = '#cba6f7' })

-- Source selector highlights
vim.api.nvim_set_hl(0, 'NeoTreeTabInactive', { bg = '#313244', fg = '#6c7086' })
vim.api.nvim_set_hl(0, 'NeoTreeTabActive', { bg = '#1e1e2e', fg = '#cdd6f4', bold = true })
vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorActive', { bg = '#1e1e2e', fg = '#313244' })
vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorInactive', { bg = '#313244', fg = '#313244' })

-- Remove tildes from empty lines
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE', fg = 'NONE' })

-- Enhanced Neo-tree highlights loaded

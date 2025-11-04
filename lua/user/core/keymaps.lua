-- Core Neovim keymaps configuration
-- This file contains all the basic keymaps and which-key group definitions

-- ============================================================================
-- Basic Keymaps (No Leader)
-- ============================================================================

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Clear highlights on escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Better indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better paste (don't yank replaced text)
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- ============================================================================
-- Leader Keymaps with Which-Key Groups
-- ============================================================================

-- Define which-key groups (deferred until which-key is loaded)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local wk = require('which-key')
    
    wk.add({
  -- Top-level single key mappings
  { '<leader>w', '<cmd>w<CR>', desc = 'Save file' },
  { '<leader>q', '<cmd>q<CR>', desc = 'Quit' },
  { '<leader>x', '<cmd>x<CR>', desc = 'Save and quit' },
  { '<leader>h', '<cmd>nohlsearch<CR>', desc = 'Clear highlights' },
  
  -- Find operations (Telescope)
  { '<leader>f', group = 'Find' },
  { '<leader>ff', desc = 'Find files' }, -- Set by Telescope
  { '<leader>fg', desc = 'Live grep' }, -- Set by Telescope
  { '<leader>fb', desc = 'Find buffers' }, -- Set by Telescope
  { '<leader>fh', desc = 'Help tags' }, -- Set by Telescope
  { '<leader>fr', desc = 'Recent files' }, -- Set by Telescope
  { '<leader>fw', desc = 'Find word' }, -- Set by Telescope
  { '<leader>fc', desc = 'Commands' }, -- Set by Telescope
  { '<leader>fk', desc = 'Keymaps' }, -- Set by Telescope
  { '<leader>fs', desc = 'Document symbols' }, -- Set by Telescope
  { '<leader>fS', desc = 'Workspace symbols' }, -- Set by Telescope
  { '<leader>fn', '<cmd>enew<CR>', desc = 'New file' },
  
  -- Buffer operations
  { '<leader>b', group = 'Buffer' },
  { '<leader>bd', '<cmd>bd<CR>', desc = 'Delete buffer' },
  { '<leader>bD', '<cmd>bd!<CR>', desc = 'Force delete buffer' },
  { '<leader>bn', '<cmd>bnext<CR>', desc = 'Next buffer' },
  { '<leader>bp', '<cmd>bprevious<CR>', desc = 'Previous buffer' },
  { '<leader>bl', '<cmd>ls<CR>', desc = 'List buffers' },
  
  -- Window operations
  { '<leader>s', group = 'Split' },
  { '<leader>sv', '<cmd>vsplit<CR>', desc = 'Vertical split' },
  { '<leader>sh', '<cmd>split<CR>', desc = 'Horizontal split' },
  { '<leader>se', '<C-w>=', desc = 'Equal splits' },
  { '<leader>sx', '<cmd>close<CR>', desc = 'Close split' },
  { '<leader>sm', '<cmd>only<CR>', desc = 'Maximize split' },
  
  -- Tab operations
  { '<leader>t', group = 'Tab' },
  { '<leader>tn', '<cmd>tabnew<CR>', desc = 'New tab' },
  { '<leader>tc', '<cmd>tabclose<CR>', desc = 'Close tab' },
  { '<leader>to', '<cmd>tabonly<CR>', desc = 'Close other tabs' },
  { '<leader>tl', '<cmd>tabnext<CR>', desc = 'Next tab' },
  { '<leader>th', '<cmd>tabprevious<CR>', desc = 'Previous tab' },
  
  -- Explorer (Neo-tree)
  { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle Explorer' },
  { '<leader>o', '<cmd>Neotree focus<CR>', desc = 'Focus Explorer' },
  
  -- LSP operations (when LSP is attached)
  { '<leader>l', group = 'LSP' },
  { '<leader>li', '<cmd>LspInfo<CR>', desc = 'LSP Info' },
  { '<leader>lr', '<cmd>LspRestart<CR>', desc = 'Restart LSP' },
  { '<leader>ls', '<cmd>LspStart<CR>', desc = 'Start LSP' },
  { '<leader>lS', '<cmd>LspStop<CR>', desc = 'Stop LSP' },
  
  -- Code operations (set by LSP on_attach)
  { '<leader>c', group = 'Code' },
  { '<leader>ca', desc = 'Code action' }, -- Set by LSP
  { '<leader>cr', desc = 'Rename' }, -- Will add this
  { '<leader>cf', desc = 'Format' }, -- Will add this
  { '<leader>cd', desc = 'Show diagnostic' }, -- Will add this
  
  -- Diagnostics
  { '<leader>d', desc = 'Show diagnostic' }, -- Set by LSP
  
  -- Mason (package manager)
  { '<leader>m', '<cmd>Mason<CR>', desc = 'Mason (LSP/Tools)' },
  
  -- Treesitter
  { '<leader>T', group = 'Treesitter' },
  { '<leader>Ti', '<cmd>TSInstallInfo<CR>', desc = 'Treesitter Info' },
  { 
    '<leader>Tu', 
    function()
      -- Check if TSUpdate command exists (treesitter needs to be loaded)
      if vim.fn.exists(':TSUpdate') == 2 then
        vim.cmd('TSUpdate')
      else
        -- If command doesn't exist, try using the API directly
        local ok, ts_install = pcall(require, 'nvim-treesitter.install')
        if ok then
          ts_install.update({ with_sync = false })
        else
          vim.notify('Treesitter not available. Open a file first or wait for Treesitter to load.', vim.log.levels.WARN)
        end
      end
    end,
    desc = 'Update parsers' 
  },
  { '<leader>Th', '<cmd>TSHighlightCapturesUnderCursor<CR>', desc = 'Highlight info' },
  
  -- Comment toggle (set by Comment.nvim plugin)
  { '<leader>/', desc = 'Toggle comment' },
  
  -- Help/Documentation
  { '<leader>?', group = 'Help' },
  { '<leader>?h', '<cmd>help<CR>', desc = 'Help' },
  { '<leader>?k', '<cmd>Telescope keymaps<CR>', desc = 'Keymaps' },
  { '<leader>?c', '<cmd>checkhealth<CR>', desc = 'Check health' },
  { '<leader>?v', '<cmd>version<CR>', desc = 'Version' },
    })
  end,
})

-- ============================================================================
-- LSP Keymaps (Applied when LSP attaches - for reference)
-- ============================================================================
-- These are set in lua/user/lsp/init.lua on_attach function:
--
-- Navigation:
--   gd          - Go to definition
--   gD          - Go to declaration
--   gi          - Go to implementation
--   gr          - Show references
--   K           - Hover documentation
--
-- Code actions:
--   <leader>rn  - Rename symbol
--   <leader>ca  - Code action
--   <leader>f   - Format file
--
-- Diagnostics:
--   [d          - Previous diagnostic
--   ]d          - Next diagnostic
--   <leader>d   - Show diagnostic

-- ============================================================================
-- Treesitter Text Objects (Applied when Treesitter loads - for reference)
-- ============================================================================
-- These are set in lua/user/plugins/init.lua treesitter config:
--
-- Selection:
--   <CR>        - Expand selection
--   <S-CR>      - Expand to scope
--   <BS>        - Shrink selection
--
-- Text objects (in visual/operator mode):
--   af/if       - Outer/inner function
--   ac/ic       - Outer/inner class
--   aa/ia       - Outer/inner parameter
--
-- Navigation:
--   ]f/[f       - Next/previous function start
--   ]F/[F       - Next/previous function end
--   ]c/[c       - Next/previous class start
--   ]C/[C       - Next/previous class end

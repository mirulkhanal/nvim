-- Which-key configuration
-- Useful plugin to show you pending keybinds.

return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Enhanced visual appearance (updated for new which-key API)
    win = {
      border = 'rounded', -- rounded, single, double, shadow, none
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },

    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },

    -- Better sorting and grouping (updated for new which-key API)
    filter = { event = 'key' }, -- only show keymaps, hide other mappings
    show_help = true, -- show help message on the command line when the popup is visible

    -- Document existing key chains with better organization
    spec = {
      { '<leader>s', group = '🔍 [S]earch' },
      { '<leader>t', group = '🔧 [T]oggle' },
      { '<leader>h', group = '📝 Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>f', group = '✨ [F]ormat' },
      { '<leader>q', group = '🚨 [Q]uickfix' },
      { '<leader>/', group = '🔍 Search in Buffer' },
      { '<leader><leader>', group = '📁 Find Buffers' },
      { '<leader>w', group = '💾 [W]rite/Save' },
      { '<leader>W', group = '💾 [W]rite and Quit' },
      { '<leader>x', group = '🚪 E[x]it' },
      { '<leader>H', group = '🧹 Clear [H]ighlights' },
      { '<leader>e', group = '📁 [E]xplorer' },
      { '<leader>u', group = '🔧 [U]pdate' },
      { '<leader>r', group = '🔄 [R]eload' },
      -- Add more groups as you add keymaps
    },
  },
}

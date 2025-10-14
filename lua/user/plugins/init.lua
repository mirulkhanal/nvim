-- Plugin manager setup
-- This file sets up lazy.nvim and loads all plugins

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Which-key for keymap hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 0,
      icons = {
        mappings = false, -- Disable all icons
      },
    },
  },

  -- Mason for managing external tools (LSP servers, formatters, linters)
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      })
    end,
  },

  -- LSP Configuration with automatic setup
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require('mason-lspconfig').setup({
            -- Automatically install these language servers
            ensure_installed = {
              'ts_ls',      -- TypeScript/JavaScript
              'lua_ls',     -- Lua
            },
            -- Automatically setup all installed servers
            automatic_installation = true,
          })
        end,
      },
    },
    config = function()
      -- Load our LSP configuration
      require('user.lsp')
    end,
  },


  -- Alpha dashboard (beautiful startup screen)
  {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    event = 'VimEnter',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },

  -- Treesitter for enhanced syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'typescript', 'javascript', 'json', 'lua', 'vim', 'vimdoc' },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Neo-tree file explorer (VS Code-like with enhanced styling)
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle Explorer' },
      { '<leader>o', '<cmd>Neotree focus<CR>', desc = 'Focus Explorer' },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '▸',
          expander_expanded = '▾',
          expander_highlight = 'NeoTreeExpander',
        },
        git_status = {
          symbols = {
            added     = '✚',
            modified  = '●',
            deleted   = '✖',
            renamed   = '➜',
            untracked = '★',
            ignored   = '◌',
            unstaged  = '✗',
            staged    = '✓',
            conflict  = '⚡',
          },
        },
        modified = {
          symbol = '●',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        type = {
          default = '󰈙',
        },
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            'node_modules',
            '.git',
          },
          hide_by_pattern = {},
          always_show = {},
          never_show = {},
          never_show_by_pattern = {},
        },
      },
      window = {
        position = 'left',
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['<space>'] = 'none',
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'revert_preview',
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['a'] = {
            'add',
            config = {
              show_path = 'none'
            }
          },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
        },
      },
      source_selector = {
        winbar = true,
        content_layout = 'center',
        tabs_layout = 'equal',
        sources = {
          {
            source = 'filesystem',
            display_name = ' 󰉓 Files ',
          },
          {
            source = 'git_status',
            display_name = ' 󰊢 Git ',
          },
        },
      },
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = 'no'
          end,
        },
      },
    },
  },
})

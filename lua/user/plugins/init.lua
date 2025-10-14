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
  -- Gruvbox Material colorscheme
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Configuration for gruvbox-material
      vim.g.gruvbox_material_background = 'hard' -- 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_foreground = 'material' -- 'material', 'mix', 'original'
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_transparent_background = 0 -- 0 = opaque, 1 = transparent, 2 = transparent + UI
      vim.g.gruvbox_material_better_performance = 1
      
      -- Load the colorscheme
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },

  -- Lualine statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'gruvbox-material',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true, -- Single statusline for all windows
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 
          { 'filename', path = 1 } -- Show relative path
        },
        lualine_x = { 
          {
            -- Show LSP status
            function()
              local clients = vim.lsp.get_active_clients({ bufnr = 0 })
              if #clients == 0 then
                return ''
              end
              local client_names = {}
              for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
              end
              return '  ' .. table.concat(client_names, ', ')
            end,
          },
          'encoding', 
          'fileformat', 
          'filetype' 
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      extensions = { 'neo-tree', 'lazy' }
    },
  },

  -- Telescope fuzzy finder (like Ctrl+P in VSCode)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Find word' },
      { '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
      { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document symbols' },
      { '<leader>fS', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace symbols' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      
      telescope.setup({
        defaults = {
          prompt_prefix = '🔍 ',
          selection_caret = '➜ ',
          path_display = { 'truncate' },
          file_ignore_patterns = { 
            'node_modules', 
            '.git/', 
            'dist/',
            'build/',
            '%.lock',
          },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<Esc>'] = actions.close,
            },
            n = {
              ['q'] = actions.close,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            },
          },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          -- Enable preview
          preview = {
            enable = true,
            treesitter = true,
          },
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
            previewer = true,
            hidden = false,
          },
          live_grep = {
            theme = 'dropdown',
            previewer = true,
          },
          buffers = {
            theme = 'dropdown',
            previewer = true,
            initial_mode = 'normal',
            mappings = {
              i = {
                ['<C-d>'] = actions.delete_buffer,
              },
              n = {
                ['dd'] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })
      
      -- Load fzf extension if available
      pcall(telescope.load_extension, 'fzf')
    end,
  },

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
      
      -- Auto-install these servers
      local mason_registry = require('mason-registry')
      local servers = {
        'typescript-language-server',
        'lua-language-server',
      }
      
      for _, server in ipairs(servers) do
        if not mason_registry.is_installed(server) then
          vim.cmd('MasonInstall ' .. server)
        end
      end
    end,
  },

  -- LSP Configuration (pure vim.lsp, no lspconfig)
  {
    'nvim-lua/plenary.nvim', -- Required for some LSP features
    lazy = false,
    config = function()
      -- Load our LSP configuration after Mason is ready
      vim.defer_fn(function()
        require('user.lsp')
      end, 100)
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects', -- Enhanced text objects
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        -- Install parsers for these languages
        ensure_installed = {
          'typescript',
          'javascript',
          'tsx',
          'json',
          'jsonc',
          'lua',
          'vim',
          'vimdoc',
          'markdown',
          'markdown_inline',
          'html',
          'css',
          'bash',
          'regex',
        },
        
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        
        -- Syntax highlighting
        highlight = {
          enable = true,
          -- Disable for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        
        -- Indentation based on treesitter
        indent = {
          enable = true,
          -- Disable for specific languages if needed
          disable = {},
        },
        
        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<S-CR>',
            node_decremental = '<BS>',
          },
        },
        
        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']c'] = '@class.outer',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']C'] = '@class.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[c'] = '@class.outer',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[C'] = '@class.outer',
            },
          },
        },
      })
      
      -- Enable folding based on treesitter
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false -- Don't fold by default
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

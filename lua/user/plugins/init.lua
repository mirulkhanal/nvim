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
  -- Clipboard fallback for TTY/tmux via OSC52
  {
    'ojroques/nvim-osc52',
    event = { 'TextYankPost' },
    config = function()
      local ok, osc52 = pcall(require, 'osc52')
      if not ok then
        return
      end
      osc52.setup({
        max_length = 0, -- no limit
        silent = true,
        trim = false,
      })

      -- Use OSC52 as a transparent provider for unnamedplus fallback in TTY
      local function is_headless_or_tty()
        return not (vim.fn.has('clipboard') == 1 and vim.fn.has('unnamedplus') == 1)
      end

      -- If no GUI clipboard is present, route yanks to OSC52
      if is_headless_or_tty() then
        vim.g.clipboard = {
          name = 'osc52',
          copy = {
            ['+'] = function(lines, _)
              osc52.copy(table.concat(lines, '\n'))
            end,
            ['*'] = function(lines, _)
              osc52.copy(table.concat(lines, '\n'))
            end,
          },
          paste = {
            ['+'] = function()
              return { vim.fn.getreg('+') }, vim.fn.getregtype('+')
            end,
            ['*'] = function()
              return { vim.fn.getreg('*') }, vim.fn.getregtype('*')
            end,
          },
        }
      end

      -- Also automatically send yanked text via OSC52 to keep external clipboard in sync
      local augroup = vim.api.nvim_create_augroup('Osc52Yank', { clear = true })
      vim.api.nvim_create_autocmd('TextYankPost', {
        group = augroup,
        callback = function()
          if vim.v.event.operator == 'y' and vim.v.event.regname ~= '"' then
            local yanked = vim.fn.getreg(vim.v.event.regname)
            if yanked and #yanked > 0 then
              pcall(osc52.copy, yanked)
            end
          end
        end,
      })
    end,
  },
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
            function()
              return '▶ Run'
            end,
            cond = function()
              return require('user.core.runner').can_run()
            end,
            on_click = function(_, button)
              if button == 'l' then
                vim.cmd('RunFile')
              end
            end,
          },
          {
            -- Show LSP status
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
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

  -- Autopairs - automatically close brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({
        check_ts = true, -- Use treesitter
        ts_config = {
          lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' },
          java = false, -- Don't check treesitter on java
        },
        disable_filetype = { 'TelescopePrompt', 'vim' },
        fast_wrap = {
          map = '<M-e>', -- Alt+e to fast wrap
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment'
        },
      })
    end,
  },

  -- Auto tag closing for HTML/JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true -- Auto close on trailing </
        },
      })
    end,
  },

  -- Multi-cursor editing (like VSCode Ctrl+D)
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      -- Use Ctrl+Down/Up for multi-cursor
      vim.g.VM_maps = {
        ['Find Under'] = '<C-d>', -- Ctrl+d like VSCode
        ['Find Subword Under'] = '<C-d>',
        ['Skip Region'] = '<C-x>',
        ['Remove Region'] = '<C-p>',
        ['Add Cursor Down'] = '<C-Down>',
        ['Add Cursor Up'] = '<C-Up>',
      }
      vim.g.VM_theme = 'purplegray'
      vim.g.VM_highlight_matches = 'underline'
    end,
  },

  -- Comment.nvim for toggling comments
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring', -- Treesitter integration for JSX/TSX
    },
    config = function()
      local context_commentstring = require('ts_context_commentstring')
      context_commentstring.setup({ enable_autocmd = false })
      local context_pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

      require('Comment').setup({
        -- Add a space between comment and the line
        padding = true,
        -- Should key mappings be created
        mappings = {
          basic = true,
          extra = false,
        },
        -- Function to call before commenting
        pre_hook = function(ctx)
          local ok, commentstring = pcall(context_pre_hook, ctx)
          return ok and commentstring or nil
        end,
      })
      
      -- Custom keymaps
      local api = require('Comment.api')
      
      -- Toggle comment on current line (line comment)
      vim.keymap.set('n', '<leader>/', function()
        api.toggle.linewise.current()
      end, { desc = 'Toggle comment' })
      
      -- Toggle block comment on selection (/* */ style)
      vim.keymap.set('v', '<leader>/', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.blockwise(vim.fn.visualmode())
      end, { desc = 'Toggle block comment' })
      
      -- Additional keymaps:
      -- gcc - toggle line comment
      -- gc  - toggle line comment (visual)
      -- gbc - toggle block comment (current line)
      -- gb  - toggle block comment (visual)
      -- These are set by Comment.nvim automatically
    end,
  },

  -- Surround text objects (like VSCode's bracket wrapping)
  {
    'kylechui/nvim-surround',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = '<C-g>s',
          insert_line = '<C-g>S',
          normal = 'ys',
          normal_cur = 'yss',
          normal_line = 'yS',
          normal_cur_line = 'ySS',
          visual = 'S',
          visual_line = 'gS',
          delete = 'ds',
          change = 'cs',
        },
      })
    end,
  },

  -- Indent guides (like VSCode indent lines)
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '▏',
        tab_char = '▏',
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
        },
      },
    },
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
    lazy = false,
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
        'jdtls',
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
  },

  -- Popup completion for LSP, paths, snippets, and words in open buffers.
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    lazy = false,
    opts = {
      keymap = { preset = 'enter' },
      completion = {
        menu = { auto_show = true },
        documentation = { auto_show = false },
        list = {
          selection = { preselect = false },
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      -- Show function signatures and the active argument while typing calls.
      signature = {
        enabled = true,
        trigger = {
          enabled = true,
          -- Refresh the active-parameter highlight as the argument is typed.
          show_on_keyword = true,
          show_on_trigger_character = true,
        },
        window = { border = 'rounded' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    config = function(_, opts)
      local completion = require('blink.cmp')
      completion.setup(opts)

      -- Preserve the capability table already captured by the native LSP callbacks.
      local lsp = require('user.lsp')
      local enhanced = completion.get_lsp_capabilities(lsp.capabilities)
      for key in pairs(lsp.capabilities) do
        lsp.capabilities[key] = nil
      end
      for key, value in pairs(enhanced) do
        lsp.capabilities[key] = value
      end
    end,
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      local lsp = require('user.lsp')
      local function find_jdtls_java_home()
        local candidates = {}
        if vim.env.JAVA_HOME and vim.env.JAVA_HOME ~= '' then
          table.insert(candidates, vim.env.JAVA_HOME .. '/bin/java')
        end
        for _, java in ipairs(vim.fn.glob('/usr/lib/jvm/*/bin/java', false, true)) do
          table.insert(candidates, java)
        end
        local path_java = vim.fn.exepath('java')
        if path_java ~= '' then
          table.insert(candidates, path_java)
        end

        local best_home, best_version
        for _, java in ipairs(candidates) do
          if vim.fn.executable(java) == 1 then
            local result = vim.system({ java, '-version' }, { text = true }):wait()
            local output = (result.stdout or '') .. (result.stderr or '')
            local version = tonumber(output:match('version "(%d+)') or output:match('openjdk (%d+)'))
            if version and version >= 21 and (not best_version or version > best_version) then
              best_home = vim.fs.dirname(vim.fs.dirname(java))
              best_version = version
            end
          end
        end
        return best_home, best_version
      end
      local java_home = find_jdtls_java_home()

      local function start_jdtls(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end
        if not java_home then
          vim.notify('JDTLS requires Java 21 or newer; no compatible Java runtime was found.', vim.log.levels.ERROR)
          return
        end
        local path = vim.api.nvim_buf_get_name(bufnr)
        local directory = vim.fs.dirname(path)
        local root_dir = vim.fs.root(directory, {
          'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'build.gradle.kts',
          'settings.gradle', 'settings.gradle.kts', 'build.xml', '.git',
        }) or directory
        local workspace_dir = vim.fn.stdpath('cache')
          .. '/jdtls/' .. vim.fn.sha256(root_dir):sub(1, 12)
        vim.fn.mkdir(workspace_dir, 'p')

        local jdtls_bin = vim.fn.exepath('jdtls')
        if jdtls_bin == '' then
          jdtls_bin = 'jdtls'
        end
        local config = {
          cmd = { jdtls_bin, '-data', workspace_dir },
          cmd_env = { JAVA_HOME = java_home },
          root_dir = root_dir,
          capabilities = lsp.capabilities,
          on_attach = lsp.on_java_attach,
          settings = {
            java = {
              format = { enabled = true },
              inlayHints = {
                parameterNames = { enabled = 'all' },
              },
            },
          },
        }

        local function start_when_installed(attempts_left)
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end
          if vim.fn.executable(jdtls_bin) == 1 then
            require('jdtls').start_or_attach(config, nil, { bufnr = bufnr })
          elseif attempts_left > 0 then
            vim.defer_fn(function()
              start_when_installed(attempts_left - 1)
            end, 1000)
          else
            vim.notify('JDTLS is not installed. Install it with :Mason.', vim.log.levels.WARN)
          end
        end
        start_when_installed(60)
      end

      -- Start for the buffer that triggered lazy loading, and for later Java buffers.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function(args)
          start_jdtls(args.buf)
        end,
      })

      if vim.bo.filetype == 'java' then
        start_jdtls(vim.api.nvim_get_current_buf())
      end
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

  -- Treesitter parser installation and native Neovim integration
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local treesitter = require('nvim-treesitter')
      local parsers = {
        'typescript', 'javascript', 'tsx', 'json', 'jsonc', 'lua', 'vim',
        'vimdoc', 'markdown', 'markdown_inline', 'html', 'css', 'bash', 'regex',
      }

      if type(treesitter.install) == 'function' then
        -- nvim-treesitter main API (new standalone parser installer).
        treesitter.setup()
        treesitter.install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
          pattern = {
            'typescript', 'typescriptreact', 'javascript', 'javascriptreact',
            'json', 'jsonc', 'lua', 'vim', 'vimdoc', 'markdown', 'html', 'css',
            'sh', 'bash',
          },
          callback = function(args)
            local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf))
            if file_size > 100 * 1024 then
              return
            end
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            local function start_when_ready(attempts_left)
              if not vim.api.nvim_buf_is_valid(args.buf) then
                return
              end
              local ok = pcall(vim.treesitter.start, args.buf)
              if not ok and attempts_left > 0 then
                vim.defer_fn(function()
                  start_when_ready(attempts_left - 1)
                end, 1000)
              end
            end
            start_when_ready(60)
          end,
        })
      else
        -- Backward-compatible setup for checkouts that have not synced yet.
        require('nvim-treesitter.configs').setup({
          ensure_installed = parsers,
          auto_install = true,
          highlight = {
            enable = true,
            disable = function(_, bufnr)
              local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
              return size > 100 * 1024
            end,
          },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<CR>',
              node_incremental = '<CR>',
              scope_incremental = '<S-CR>',
              node_decremental = '<BS>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                af = '@function.outer', ['if'] = '@function.inner',
                ac = '@class.outer', ic = '@class.inner',
                aa = '@parameter.outer', ia = '@parameter.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
              goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
              goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
              goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
            },
          },
        })
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      end
      vim.opt.foldenable = false
    end,
  },

  -- Treesitter text objects are configured by the matching API generation.
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
    config = function()
      local ok, textobjects = pcall(require, 'nvim-treesitter-textobjects')
      if not ok or type(textobjects.setup) ~= 'function' then
        return -- Legacy textobjects are configured through nvim-treesitter.configs.
      end

      textobjects.setup({ select = { lookahead = true }, move = { set_jumps = true } })
      local select = require('nvim-treesitter-textobjects.select').select_textobject
      local select_maps = {
        af = '@function.outer', ['if'] = '@function.inner',
        ac = '@class.outer', ic = '@class.inner',
        aa = '@parameter.outer', ia = '@parameter.inner',
      }
      for _, mode in ipairs({ 'x', 'o' }) do
        for key, query in pairs(select_maps) do
          local capture = query
          vim.keymap.set(mode, key, function() select(capture, 'textobjects') end)
        end
      end

      local move = require('nvim-treesitter-textobjects.move')
      local move_maps = {
        [']f'] = { move.goto_next_start, '@function.outer' },
        [']c'] = { move.goto_next_start, '@class.outer' },
        ['[f'] = { move.goto_previous_start, '@function.outer' },
        ['[c'] = { move.goto_previous_start, '@class.outer' },
        [']F'] = { move.goto_next_end, '@function.outer' },
        [']C'] = { move.goto_next_end, '@class.outer' },
        ['[F'] = { move.goto_previous_end, '@function.outer' },
        ['[C'] = { move.goto_previous_end, '@class.outer' },
      }
      for key, mapping in pairs(move_maps) do
        local callback, capture = mapping[1], mapping[2]
        vim.keymap.set({ 'n', 'x', 'o' }, key, function() callback(capture, 'textobjects') end)
      end
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

  -- ToggleTerm integrated terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
      { '<leader>\\f', '<cmd>ToggleTerm direction=float<CR>', desc = 'Terminal float' },
      { '<leader>\\h', '<cmd>ToggleTerm direction=horizontal size=15<CR>', desc = 'Terminal horizontal' },
      { '<leader>\\v', '<cmd>ToggleTerm direction=vertical size=60<CR>', desc = 'Terminal vertical' },
      {
        '<leader>\\g',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new({
            cmd = 'lazygit',
            hidden = true,
            direction = 'float',
            close_on_exit = true,
          })
          lazygit:toggle()
        end,
        desc = 'Terminal lazygit',
      },
    },
    opts = {
      size = 15,
      shading_factor = 2,
      direction = 'float',
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
      },
    },
    config = function(_, opts)
      local toggleterm = require('toggleterm')
      toggleterm.setup(opts)

      -- Provide consistent window navigation inside terminals
      local function set_terminal_keymaps(event)
        local options = { buffer = event.buf }
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], options)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], options)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], options)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], options)
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], options)

        local function hide_current_terminal()
          local _, terminal = require('toggleterm.terminal').identify()
          if terminal then
            terminal:close()
          end
        end
        vim.keymap.set('t', '<C-q>', hide_current_terminal, {
          buffer = event.buf,
          desc = 'Hide terminal and keep it running',
        })
        vim.keymap.set('n', '<C-q>', hide_current_terminal, {
          buffer = event.buf,
          desc = 'Hide terminal and keep it running',
        })
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        callback = set_terminal_keymaps,
      })
    end,
  },
})

-- LSP Configuration (Pure vim.lsp API - NO lspconfig)
-- Uses ONLY Neovim's native LSP client with Mason-installed servers
-- Automatic setup for all Mason-installed language servers

-- Configure diagnostics appearance
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-- Diagnostic signs
local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP keymaps that will be set when LSP attaches to a buffer
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation (g prefix)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'LSP: Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'LSP: Go to implementation' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: Show references' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Hover documentation' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: Signature help' }))
  
  -- Code actions (<leader>c prefix)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
  vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('force', opts, { desc = 'Format file' }))
  vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostic' }))
  
  -- Also keep <leader>f for quick format
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('force', opts, { desc = 'Format file' }))
  
  -- Diagnostics navigation
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostic' }))
  
  -- Show a message when LSP attaches
  vim.notify('LSP attached: ' .. client.name, vim.log.levels.INFO)
end

-- Default capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Helper to find project root
local function find_root(patterns)
  local path = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.dirname(vim.fs.find(patterns, { path = path, upward = true })[1])
  return root
end

-- TypeScript/JavaScript Language Server
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(args)
    local root_dir = find_root({ 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' })
    
    if vim.fn.executable('typescript-language-server') == 0 then
      vim.notify('typescript-language-server not found. Install via :Mason', vim.log.levels.WARN)
      return
    end
    
    vim.lsp.start({
      name = 'typescript-language-server',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        preferences = {
          includeInlayParameterNameHints = 'all',
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        }
      },
    })
  end,
})

-- Lua Language Server
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function(args)
    local root_dir = find_root({ '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' })
    
    if vim.fn.executable('lua-language-server') == 0 then
      vim.notify('lua-language-server not found. Install via :Mason', vim.log.levels.WARN)
      return
    end
    
    vim.lsp.start({
      name = 'lua-language-server',
      cmd = { 'lua-language-server' },
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              '${3rd}/luv/library',
            },
          },
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
})

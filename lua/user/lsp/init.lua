-- LSP Configuration (AstroNvim-style)
-- Automatic setup for all language servers installed via Mason
-- Just install a server in Mason and it works automatically!

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
  
  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show references' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))
  
  -- Code actions
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('force', opts, { desc = 'Format' }))
  
  -- Diagnostics
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostic' }))
  
  -- Show a message when LSP attaches
  vim.notify('LSP attached: ' .. client.name, vim.log.levels.INFO)
end

-- Default capabilities (for autocompletion support if you add it later)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Get mason-lspconfig
local mason_lspconfig = require('mason-lspconfig')

-- Setup mason-lspconfig to automatically configure all installed servers
mason_lspconfig.setup_handlers({
  -- Default handler - applies to all servers
  function(server_name)
    require('lspconfig')[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  
  -- Custom handler for lua_ls (better Neovim config support)
  ['lua_ls'] = function()
    require('lspconfig').lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
  
  -- Custom handler for TypeScript (with inlay hints)
  ['ts_ls'] = function()
    require('lspconfig').ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          },
        },
      },
    })
  end,
})

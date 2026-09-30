-- LSP Configuration (Pure vim.lsp API - NO lspconfig)
-- Uses ONLY Neovim's native LSP client with Mason-installed servers
-- Automatic setup for all Mason-installed language servers

-- Configure diagnostics appearance
vim.diagnostic.config({
  -- Long messages belong in a wrapped float, not clipped inline text.
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    wrap = true,
    max_width = 80,
    max_height = 12,
    focusable = false,
  },
})

-- Show the diagnostic under the cursor after a brief pause.
local diagnostic_float_group = vim.api.nvim_create_augroup('UserDiagnosticFloat', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  group = diagnostic_float_group,
  callback = function()
    vim.diagnostic.open_float(0, { scope = 'cursor' })
  end,
})

-- Keep virtual parameter labels subtle, like editor inlay hints.
vim.api.nvim_set_hl(0, 'LspInlayHint', { link = 'Comment' })

-- Native vim.lsp does not provide lspconfig's :LspInfo command.
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify(('No LSP clients attached (filetype: %s).'):format(vim.bo.filetype), vim.log.levels.INFO)
    return
  end

  local lines = { ('LSP clients for %s:'):format(vim.api.nvim_buf_get_name(0)) }
  for _, client in ipairs(clients) do
    local formatting = client.server_capabilities.documentFormattingProvider and 'yes' or 'no'
    lines[#lines + 1] = ('- %s (id %d), formatting: %s, root: %s'):format(
      client.name,
      client.id,
      formatting,
      client.config.root_dir or 'unknown'
    )
  end
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO, { title = 'LSP Info' })
end, { desc = 'Show LSP clients attached to current buffer' })

-- Diagnostic signs
local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP keymaps that will be set when LSP attaches to a buffer
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Enable inlay hints for this buffer. Some servers register support after attach.
  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
  
  -- Navigation (g prefix)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'LSP: Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'LSP: Go to implementation' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: Show references' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Hover documentation' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: Signature help' }))
  
  -- Quick actions (VSCode-like)
  vim.keymap.set('n', '<C-Space>', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action (auto-import)' }))
  
  -- Diagnostics navigation
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  
  -- Show a message when LSP attaches
  vim.notify('LSP attached: ' .. client.name, vim.log.levels.INFO)
end

local function on_java_attach(client, bufnr)
  on_attach(client, bufnr)
  if not client:supports_method('textDocument/formatting', bufnr) then
    return
  end

  local group = vim.api.nvim_create_augroup('JavaFormatOnSave' .. bufnr, { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        async = false,
        timeout_ms = 3000,
        filter = function(format_client)
          return format_client.name == 'jdtls'
        end,
      })
    end,
  })
end

-- Default capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Helper to find project root
local function find_root(bufnr, patterns)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local directory = vim.fs.dirname(path)
  return vim.fs.root(directory, patterns) or directory
end

-- TypeScript/JavaScript Language Server
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(args)
    local root_dir = find_root(args.buf, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' })
    
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
    local root_dir = find_root(args.buf, { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' })
    
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

return {
  capabilities = capabilities,
  on_attach = on_attach,
  on_java_attach = on_java_attach,
}

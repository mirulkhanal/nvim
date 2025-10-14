-- LSP Configuration
-- Modern approach using ONLY vim.lsp.start() API + Mason installation
-- NO lspconfig at all - completely clean implementation

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Custom diagnostic signs (using simple text since we disabled icons)
local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP keymaps
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Navigation
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Show documentation' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))

  -- Code actions
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Type definition' }))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'References' }))

  -- Diagnostics
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, vim.tbl_extend('force', opts, { desc = 'Format' }))
end

-- Helper function to get Mason binary path
local function get_mason_path(server_name)
  local mason_registry = require('mason-registry')
  if mason_registry.is_installed(server_name) then
    return mason_registry.get_package(server_name):get_install_path()
  end
  return nil
end

-- TypeScript/JavaScript Language Server
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(args)
    local root_dir = vim.fs.dirname(vim.fs.find({ 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }, { upward = true })[1])
    
    -- Try Mason path first, fallback to system PATH
    local cmd = { 'typescript-language-server', '--stdio' }
    local mason_path = get_mason_path('typescript-language-server')
    if mason_path then
      cmd[1] = mason_path .. '/node_modules/.bin/typescript-language-server'
    end

    local client = vim.lsp.start({
      name = 'typescript-language-server',
      cmd = cmd,
      root_dir = root_dir,
      on_attach = on_attach,
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
    vim.lsp.buf_attach_client(args.buf, client)
  end,
})

-- JSON Language Server
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc' },
  callback = function(args)
    local root_dir = vim.fs.dirname(vim.fs.find({ 'package.json', '.git' }, { upward = true })[1])
    
    -- Try Mason path first, fallback to system PATH
    local cmd = { 'json-lsp' }
    local mason_path = get_mason_path('json-lsp')
    if mason_path then
      cmd[1] = mason_path .. '/node_modules/.bin/json-lsp'
    end

    local client = vim.lsp.start({
      name = 'jsonls',
      cmd = cmd,
      root_dir = root_dir,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.buf_attach_client(args.buf, client)
  end,
})

-- Auto-format on save for supported file types
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.json' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- LSP configuration loaded successfully

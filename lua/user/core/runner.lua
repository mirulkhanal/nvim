local M = {}

local function java_executable()
  local clients = vim.lsp.get_clients({ bufnr = 0, name = 'jdtls' })
  local java_home = clients[1] and clients[1].config.cmd_env and clients[1].config.cmd_env.JAVA_HOME
  if java_home and java_home ~= '' and vim.fn.executable(java_home .. '/bin/java') == 1 then
    return java_home .. '/bin/java'
  end
  return 'java'
end

local runners = {
  java = function(file)
    return vim.fn.shellescape(java_executable()) .. ' ' .. vim.fn.shellescape(file)
  end,
  c = function(file)
    local output = vim.fn.stdpath('cache') .. '/nvim-runner/' .. vim.fn.sha256(file):sub(1, 16)
    vim.fn.mkdir(vim.fs.dirname(output), 'p')
    return 'cc ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(output)
      .. ' && ' .. vim.fn.shellescape(output)
  end,
  cpp = function(file)
    local output = vim.fn.stdpath('cache') .. '/nvim-runner/' .. vim.fn.sha256(file):sub(1, 16)
    vim.fn.mkdir(vim.fs.dirname(output), 'p')
    return 'g++ -std=c++17 ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(output)
      .. ' && ' .. vim.fn.shellescape(output)
  end,
  python = function(file)
    return 'python3 ' .. vim.fn.shellescape(file)
  end,
  javascript = function(file)
    return 'node ' .. vim.fn.shellescape(file)
  end,
  lua = function(file)
    return 'lua ' .. vim.fn.shellescape(file)
  end,
  sh = function(file)
    return 'bash ' .. vim.fn.shellescape(file)
  end,
  go = function(file)
    return 'go run ' .. vim.fn.shellescape(file)
  end,
  rust = function(file)
    local output = vim.fn.stdpath('cache') .. '/nvim-runner/' .. vim.fn.sha256(file):sub(1, 16)
    vim.fn.mkdir(vim.fs.dirname(output), 'p')
    return 'rustc ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(output)
      .. ' && ' .. vim.fn.shellescape(output)
  end,
}

local executables = {
  c = 'cc',
  cpp = 'g++',
  python = 'python3',
  javascript = 'node',
  lua = 'lua',
  sh = 'bash',
  go = 'go',
  rust = 'rustc',
}

function M.supports(filetype)
  return runners[filetype] ~= nil
end

function M.can_run(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return M.supports(vim.bo[bufnr].filetype) and vim.api.nvim_buf_get_name(bufnr) ~= ''
end

function M.run()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == '' then
    vim.notify('Save this file before running it.', vim.log.levels.WARN)
    return
  end

  if not M.supports(vim.bo[bufnr].filetype) then
    vim.notify('Run is not configured for filetype: ' .. vim.bo[bufnr].filetype, vim.log.levels.WARN)
    return
  end

  local filetype = vim.bo[bufnr].filetype
  local executable = filetype == 'java' and java_executable() or executables[filetype]
  if executable and vim.fn.executable(executable) == 0 then
    vim.notify(('Cannot run this file: `%s` is not installed or not on PATH.'):format(executable), vim.log.levels.ERROR)
    return
  end

  if vim.bo[bufnr].modified then
    local ok, err = pcall(vim.api.nvim_buf_call, bufnr, function()
      vim.cmd('write')
    end)
    if not ok then
      vim.notify('Could not save before running: ' .. tostring(err), vim.log.levels.ERROR)
      return
    end
  end

  file = vim.fn.fnamemodify(file, ':p')
  local directory = vim.fs.dirname(file)
  local root = vim.fs.root(directory, {
    '.git', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle',
    'settings.gradle.kts', 'mvnw', 'gradlew', 'go.mod', 'Cargo.toml',
  }) or directory
  local command = runners[filetype](file, root)

  local Terminal = require('toggleterm.terminal').Terminal
  Terminal:new({
    cmd = command,
    direction = 'float',
    dir = root,
    close_on_exit = false,
    display_name = 'Run: ' .. vim.fn.fnamemodify(file, ':t'),
    on_open = function(terminal)
      local function dismiss_run_output()
        local status = vim.fn.jobwait({ terminal.job_id }, 0)[1]
        if status == -1 then
          vim.notify('This program is still running. Use Ctrl-Q to hide it, then press q after it exits to delete its output.', vim.log.levels.WARN)
          return
        end
        terminal:shutdown()
      end

      for _, mode in ipairs({ 'n', 't' }) do
        vim.keymap.set(mode, 'q', dismiss_run_output, {
          buffer = terminal.bufnr,
          desc = 'Delete finished run output',
        })
      end
    end,
  }):toggle()
end

vim.api.nvim_create_user_command('RunFile', M.run, { desc = 'Run the current source file' })

return M

if vim.g.did_load_nvim_dap_plugin then
  return
end
vim.g.did_load_nvim_dap_plugin = true

vim.cmd('packadd nvim-dap')
vim.cmd('packadd nvim-dap-go')
vim.cmd('packadd nvim-dap-ui')
vim.cmd('packadd nvim-dap-virtual-text')
vim.cmd('packadd telescope-dap.nvim')

local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

require('telescope').load_extension('dap')

local function get_php_debug_path(callback)
  -- The nix build command causes a result folder to be created, which we do not want.
  local command = 'nix build nixpkgs#vscode-extensions.xdebug.php-debug --print-out-paths --no-link'
  local output = {}

  local function handle_output(job_id, data, event)
    if event == 'stdout' then
      for _, line in ipairs(data) do
        if line ~= '' then
          table.insert(output, line)
        end
      end
    elseif event == 'stderr' then
      for _, line in ipairs(data) do
        if line ~= '' then
          vim.notify('Error: ' .. line)
        end
      end
    elseif event == 'exit' then
      if #output == 0 then
        vim.notify('Command returned empty result: ' .. command)
      else
        local result = table.concat(output, '\n')
        result = vim.fn.trim(result) .. '/share/vscode/extensions/xdebug.php-debug/out/phpDebug.js'
        callback(result)
      end
    end
  end

  local job_id = vim.fn.jobstart(command, {
    on_stdout = handle_output,
    on_stderr = handle_output,
    on_exit = handle_output,
    stdout_buffered = true,
    stderr_buffered = true,
  })

  if not job_id then
    vim.notify('Failed to start job: ' .. command)
  end
end

get_php_debug_path(function(php_debug_path)
  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { php_debug_path },
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = '9003',
      log = true,
      pathMappings = {
        ['/var/www/html'] = '${workspaceFolder}',
      },
    },
  }
end)

dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/mason/bin/chrome-debug-adapter' },
}
dap.configurations.typescriptreact = {
  {
    name = 'Debug (Attach) - Remote',
    type = 'chrome',
    request = 'attach',
    -- program = "${file}",
    -- cwd = vim.fn.getcwd(),
    sourceMaps = true,
    -- reAttach = true,
    -- protocol = "inspector",
    hostName = 'localhost',
    port = 3000,
    webRoot = '${workspaceFolder}',
  },
}

require('nvim-dap-virtual-text').setup()
require('dapui').setup()

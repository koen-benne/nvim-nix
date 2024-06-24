vim.g.did_load_nvim_dap_plugin = true
if vim.g.did_load_nvim_dap_plugin then
  return
end

local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

require('telescope').load_extension('dap')

dap.adapters.php = {
    type = 'executable',
    command = "bash",
    args = {os.getenv("HOME") .. "/.local/share/nvim/mason/bin/php-debug-adapter"},
}
dap.adapters.chrome = {
    type = 'executable',
    command = "node",
    args = {os.getenv("HOME") .. "/.local/share/nvim/mason/bin/chrome-debug-adapter"},
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = '9003',
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}"
        }
    }
}
dap.configurations.typescriptreact = {
    {
        name = "Debug (Attach) - Remote",
        type = 'chrome',
        request = 'attach',
        -- program = "${file}",
        -- cwd = vim.fn.getcwd(),
        sourceMaps = true,
        -- reAttach = true,
        -- protocol = "inspector",
        hostName = "localhost",
        port = 3000,
        webRoot = "${workspaceFolder}"
    }
}

require("nvim-dap-virtual-text").setup()
require("dapui").setup()


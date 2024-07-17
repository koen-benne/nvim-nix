if vim.g.did_load_nvim_dap_plugin then
  return
end
vim.g.did_load_nvim_dap_plugin = true

vim.cmd ( 'packadd nvim-dap' )
vim.cmd ( 'packadd nvim-dap-go' )
vim.cmd ( 'packadd nvim-dap-ui' )
vim.cmd ( 'packadd nvim-dap-virtual-text' )
vim.cmd ( 'packadd telescope-dap.nvim' )

local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

require('telescope').load_extension('dap')

local function get_php_debug_path()
    local handle = io.popen("nix path-info nixpkgs#vscode-extensions.xdebug.php-debug")
    if not handle then
        error("Failed to run command: nix path-info nixpkgs#vscode-extensions.xdebug.php-debug")
    end

    local result = handle:read("*a")
    handle:close()

    if not result or result == '' then
        error("Command returned empty result: nix path-info nixpkgs#vscode-extensions.xdebug.php-debug")
    end

    return vim.fn.trim(result) .. "/share/vscode/extensions/xdebug.php-debug/out/phpDebug.js"
end

dap.adapters.php = {
    type = 'executable',
    command = "node",
    args = { get_php_debug_path() },
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


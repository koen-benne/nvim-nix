local status_lsp, lazylsp = pcall(require, "lazy-lsp")
if not status_lsp then
  return
end

require("user.plugins.lsp.handlers").setup()

lazylsp.setup {
  -- By default all available servers are set up. Exclude unwanted or misbehaving servers.
  excluded_servers = {
    "ccls", "zk",
  },
  -- Alternatively specify preferred servers for a filetype (others will be ignored).
  preferred_servers = {
    markdown = {},
    python = { "pyright", "ruff_lsp" },
    lua = { "lua_ls" },
    rust = { "rust_analyzer" },
    json = { "jsonls" },
    css = { "cssmodules" },
    typescript = { "tsserver" },
    typescriptreact = { "tsserver" },
  },
  prefer_local = true, -- Prefer locally installed servers over nix-shell
  -- Default config passed to all servers to specify on_attach callback and other options.
  default_config = {
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = require("user.plugins.lsp.handlers").on_attach,
    capabilities = require("user.plugins.lsp.handlers").capabilities,
  },
  -- Override config for specific servers that will passed down to lspconfig setup.
  -- Note that the default_config will be merged with this specific configuration so you don't need to specify everything twice.
  configs = {
    lua_ls = require "user.plugins.lsp.settings.lua_ls",
    rust_analyzer = require "user.plugins.lsp.settings.rust",
    clangd = require "user.plugins.lsp.settings.clangd",
    jsonls = require "user.plugins.lsp.settings.jsonls",
    pyright = require "user.plugins.lsp.settings.pyright",
    emmet_ls = require "user.plugins.lsp.settings.emmet_ls",
    -- cssmodules_ls = require "user.plugins.lsp.settings.cssmodules_ls",
  },
}


if vim.g.did_load_lazylsp_plugin then
  return
end
vim.g.did_load_lazylsp_plugin = true

local status_lsp, lazylsp = pcall(require, 'lazy-lsp')
if not status_lsp then
  return
end

-- This generates better error messages for typescript
require('ts-error-translator').setup()
require('user.lsp.handlers').setup()

lazylsp.setup {
  -- By default all available servers are set up. Exclude unwanted or misbehaving servers.
  excluded_servers = {
    'ccls',
    'zk',
  },
  -- Alternatively specify preferred servers for a filetype (others will be ignored).
  preferred_servers = {
    markdown = {},
    python = { 'basedpyright', 'ruff_lsp' },
    lua = { 'lua_ls' },
    nix = { 'nil_ls', 'nixd' },
    rust = { 'rust_analyzer' },
    json = { 'jsonls' },
    css = { 'cssmodules' },
    javascript = { 'ts_ls', 'eslint' },
    javascriptreact = { 'ts_ls', 'eslint' },
    typescript = { 'ts_ls', 'eslint' },
    typescriptreact = { 'ts_ls', 'eslint' },
    php = { 'intelephense', 'psalm' },
  },
  prefer_local = true, -- Prefer locally installed servers over nix-shell
  -- Default config passed to all servers to specify on_attach callback and other options.
  default_config = {
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  },
  -- Override config for specific servers that will passed down to lspconfig setup.
  -- Note that the default_config will be merged with this specific configuration so you don't need to specify everything twice.
  configs = {
    lua_ls = require('user.lsp.settings.lua_ls'),
    rust_analyzer = require('user.lsp.settings.rust'),
    clangd = require('user.lsp.settings.clangd'),
    jsonls = require('user.lsp.settings.jsonls'),
    pyright = require('user.lsp.settings.pyright'),
    emmet_ls = require('user.lsp.settings.emmet_ls'),
    intelephense = require('user.lsp.settings.intelephense'),
    -- cssmodules_ls = require "user.lsp.settings.cssmodules_ls",
  },
}

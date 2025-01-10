if vim.g.did_load_blink_plugin then
  return
end
vim.g.did_load_blink_plugin = true

vim.cmd('packadd lazy-lsp.nvim')
vim.cmd('packadd nvim-lspconfig')
vim.cmd('packadd lspsaga.nvim')
vim.cmd('packadd SchemaStore.nvim')
vim.cmd('packadd ts-error-translator.nvim')
vim.cmd('packadd blink-cmp')
vim.cmd('packadd luasnip')
vim.cmd('packadd crates.nvim')

local blink_status_ok, blink = pcall(require, 'blink.cmp')
if not blink_status_ok then
  vim.notify('Blink is not installed!')
  return
end
vim.notify('Blink is not installed!')

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  vim.notify('Luasnip is not installed!')
  return
end

local buffer_fts = {
  'markdown',
  'toml',
  'yaml',
  'json',
}

require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local icons = require('user.icons')

local kind_icons = icons.kind

vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
vim.api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })


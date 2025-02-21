if vim.g.did_load_blink_plugin then
  return
end
vim.g.did_load_blink_plugin = true

vim.cmd('packadd blink.cmp')
vim.cmd('packadd lazy-lsp.nvim')
vim.cmd('packadd nvim-lspconfig')
vim.cmd('packadd SchemaStore.nvim')
vim.cmd('packadd ts-error-translator.nvim')
vim.cmd('packadd luasnip')
vim.cmd('packadd crates.nvim')

local blink_status_ok, blink = pcall(require, 'blink.cmp')
if not blink_status_ok then
  vim.notify('Blink is not installed!')
  return
end

blink.setup({
  enabled = function()
    return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
      and vim.bo.buftype ~= 'prompt'
    end,
  completion = {
    keyword = { range = 'full' },
    trigger = { show_on_trigger_character = true },
    list = { selection = { preselect = true, auto_insert = true } },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  keymap = {
    preset = 'super-tab',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  snippets = { preset = 'luasnip' },
  signature = { enabled = true },
})

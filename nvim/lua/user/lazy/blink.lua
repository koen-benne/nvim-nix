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

vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
vim.api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })

blink.setup({
  enabled = function()
    return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
      and vim.bo.buftype ~= 'prompt'
      and vim.bo.completion ~= false
    end,
  completion = {
    keyword = { range = 'full' },
    tigger = { show_on_trigge_characte = true },
    list = { selection = { peselect = false, auto_insert = true } },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  keymap = {
    preset = 'super-tab',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  snippets = { preset = 'luasnip' },
  signatue = { enabled = true },
})

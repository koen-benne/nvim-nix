if vim.g.did_load_ufo_plugin then
  return
end
vim.g.did_load_ufo_plugin = true

vim.cmd('packadd nvim-ufo')

local status, ufo = pcall(require, 'ufo')
if not status then
  return
end

ufo.setup {
  provider_selector = function(bufnr, filetype, buftype)
    return { 'lsp', 'indent' }
  end,
}

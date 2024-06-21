if vim.g.did_load_ufo_plugin then
  return
end
vim.g.did_load_ufo_plugin = true

local status, ufo = pcall(require, "ufo")
if not status then
  return
end

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'lsp', 'indent'}
  end,
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)

if vim.g.did_load_statuscol_plugin then
  return
end
vim.g.did_load_statuscol_plugin = true

vim.cmd('packadd statuscol.nvim')

local builtin = require('statuscol.builtin')
require('statuscol').setup {
  setopt = true,
  relculright = false,
  segments = {
    { text = { '%s' }, click = 'v:lua.ScSa' },
    {
      text = { builtin.lnumfunc, ' ' },
      condition = { true, builtin.not_empty },
      click = 'v:lua.ScLa',
    },
  },
}

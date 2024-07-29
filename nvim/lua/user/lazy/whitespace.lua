if vim.g.did_load_whitespace_plugin then
  return
end
vim.g.did_load_whitespace_plugin = true

vim.cmd('packadd whitespace.nvim')

local status, whitespace = pcall(require, 'whitespace-nvim')
if not status then
  return
end

whitespace.setup {
  -- `highlight` configures which highlight is used to display
  -- trailing whitespace
  highlight = 'DiffDelete',

  -- `ignored_filetypes` configures which filetypes to ignore when
  -- displaying trailing whitespace
  ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'neo-tree', 'norg', 'alpha' },

  -- `ignore_terminal` configures whether to ignore terminal buffers
  ignore_terminal = true,
}

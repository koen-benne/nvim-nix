if vim.g.did_load_nvim_colorizer_plugin then
  return
end
vim.g.did_load_nvim_colorizer_plugin = true

local status_ok, devicons = pcall(require, 'devicons')
if not status_ok then
  return
end

devicons.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = '?',
      color = '#428850',
      cterm_color = '65',
      name = 'Zsh',
    },
  },
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
}

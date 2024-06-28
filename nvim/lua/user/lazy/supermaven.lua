if vim.g.did_load_supermaven_plugin then
  return
end
vim.g.did_load_supermaven_plugin = true

vim.cmd ( 'packadd supermaven-nvim' )

local status_ok, supermaven = pcall(require, "supermaven-nvim")
if not status_ok then
  return
end

supermaven.setup {
  keymaps = {
    accept_suggestion = "<A-l>",
  }
}

if vim.g.did_load_plugins then
  return
end
vim.g.did_load_plugins = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

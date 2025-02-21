if vim.g.did_load_snacks_plugin then
  return
end
vim.g.did_load_snacks_plugin = true

local ok, snacks = pcall(require, 'snacks')
if not ok then
  return
end

snacks.setup {
}

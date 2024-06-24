vim.g.did_load_copilot_plugin = true
if vim.g.did_load_copilot_plugin then
  return
end

-- vim.cmd [[
--   imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
--   let g:copilot_no_tab_map = v:true
-- ]]

local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
end

local status_comment_ok, comment = pcall(require, "comment")

copilot.setup {
  copilot_node_command = vim.fn.expand("$HOME") .. "/.nix-profile/bin/node",
  suggestion = {
    auto_trigger = true,
  },
}

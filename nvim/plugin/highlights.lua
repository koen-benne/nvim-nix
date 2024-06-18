if vim.g.did_load_highlights then
  return
end
vim.g.did_load_highlights = true

-- functions for setting highlights
local function fg_bg(group, guifg, guibg)
  vim.cmd('hi ' .. group .. ' guibg=' .. guibg .. ' guifg=' .. guifg)
end
local function bg(group, guibg)
  vim.cmd('hi ' .. group .. ' guibg=' .. guibg)
end

-- Telescope
fg_bg("TelescopeBorder", "#16161d", "#16161d")
fg_bg("TelescopePromptBorder", "#1a1b26", "#1a1b26")

fg_bg("TelescopePromptNormal", "#fff", "#1a1b26")
fg_bg("TelescopePromptPrefix", "#957fb8", "#b1a1b26")

bg("TelescopeNormal", "#16161d")
bg("TelescopeMatching", "#b1a1b26")
bg("TelescopeSelectionCaret", "#957fb8")
bg("TelescopeSelection", "#b1a1b26")
bg("TelescopeMultiSelection", "#b1a1b26")

fg_bg("TelescopePreviewTitle", "#000000", "#7e9cd8")
fg_bg("TelescopePromptTitle", "#000000", "#957fb8")
fg_bg("TelescopeResultsTitle", "#16161d","#16161d")

bg("TelescopeSelection", "#3b323e")

-- Neo tree
bg("NeoTreeNormal", "#16161d")
bg("NeoTreeFloatBorder", "#16161d")
fg_bg("NeoTreeFloatTitle", "#000000", "#957fb8")
bg("NeoTreeCursorLine", "#3b323e")




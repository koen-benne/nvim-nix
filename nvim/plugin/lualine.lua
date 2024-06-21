if vim.g.did_load_lualine_plugin then
  return
end
vim.g.did_load_lualine_plugin = true

---Indicators for special modes,
---@return string status
local function extra_mode_status()
  -- recording macros
  local reg_recording = vim.fn.reg_recording()
  if reg_recording ~= '' then
    return ' @' .. reg_recording
  end
  -- executing macros
  local reg_executing = vim.fn.reg_executing()
  if reg_executing ~= '' then
    return ' @' .. reg_executing
  end
  return ''
end

require('lualine').setup {
  globalstatus = true,
  sections = {
    lualine_c = {
      { extra_mode_status },
    },
  },
  options = {
    theme = 'kanagawa',
    path = 1
  },
  extensions = { 'fugitive', 'fzf', 'toggleterm', 'quickfix' },
}

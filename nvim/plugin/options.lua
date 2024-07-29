if vim.g.did_load_options then
  return
end
vim.g.did_load_options = true

local options = {
  backup = false,
  clipboard = 'unnamedplus',
  completeopt = { 'menu', 'menuone', 'noselect' }, -- cmp stuff
  mouse = 'a', -- allow mouse use
  smartcase = true,
  smartindent = true,
  number = true,
  pumheight = 10, -- pop up menu height
  incsearch = true,
  visualbell = true,
  showtabline = 1, -- only show tabline when there are more than one tab
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = 'yes', -- always show the sign column to prevent shifting text
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  wrap = true,
  autoindent = true,
  ruler = true,
  hlsearch = true,
  relativenumber = false,
  scrolloff = 8,
  sidescrolloff = 8,
  swapfile = false,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  laststatus = 2, -- Single statusline when set to 3
  guifont = 'JetBrainsMonoNL Nerd Font:h11', -- font used in GUI neovim
  cursorline = true,
  pumblend = 10,
  winblend = 10,
  conceallevel = 2,
  fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
  path = vim.o.path .. '**',
  colorcolumn = '100',
}

vim.opt.shortmess:append('c')

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Folding stuff
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim-better-whitespace options
vim.g.better_whitespace_filetypes_blacklist = {
  'NvimTree',
  'toggleterm',
  'TelescopePrompt',
  'alpha',
}

-- Enable true colour support
if vim.fn.has('termguicolors') then
  vim.o.termguicolors = true
end

-- Neovide opts
if vim.g.neovide then
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_floating_blur_amount_x = 7.0
  vim.g.neovide_floating_blur_amount_y = 7.0
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_scroll_animation_length = 0.6
  vim.g.neovide_floating_opacity = 0.6
  function ChangeScaleFactor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
end

vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave  * if &nu                   | set nornu | endif
]])

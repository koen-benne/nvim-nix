if vim.g.did_load_toggleterm_plugin then
  return
end
vim.g.did_load_toggleterm_plugin = true

vim.cmd('packadd toggleterm.nvim')

local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
  highlights = {
    NormalFloat = {
      guibg = '#15151e',
    },
    FloatBorder = {
      guibg = '#15151e',
      guifg = '#15151e',
    },
  },
  float_opts = {
    border = { ' ', ' ' },
    winblend = 8,
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local gitui = Terminal:new { cmd = 'gitui', hidden = true, direction = 'float' }

function _GITUI_TOGGLE()
  gitui:toggle()
end

local bacon = Terminal:new { cmd = 'bacon', hidden = true, direction = 'vertical', size = 50 }

function _BACON_TOGGLE()
  bacon:toggle(80)
end

local node = Terminal:new { cmd = 'node', hidden = true }

function _NODE_TOGGLE()
  node:toggle()
end

local ncdu = Terminal:new { cmd = 'ncdu', hidden = true }

function _NCDU_TOGGLE()
  ncdu:toggle()
end

local btop = Terminal:new { cmd = 'btop', hidden = true }

function _BTOP_TOGGLE()
  btop:toggle()
end

local python = Terminal:new { cmd = 'python', hidden = true }

function _PYTHON_TOGGLE()
  python:toggle()
end

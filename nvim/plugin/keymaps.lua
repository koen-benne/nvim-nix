if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local setKeymap = vim.keymap.set

-- Make space leader key
setKeymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

setKeymap("n", "<C-e>", "<Nop>")

-- Normal mode --
-- Window nav
setKeymap("n", "<C-h>", "<C-w>h")
setKeymap("n", "<C-j>", "<C-w>j")
setKeymap("n", "<C-k>", "<C-w>k")
setKeymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
setKeymap("n", "<C-[>", ":vertical resize -2<CR>")
setKeymap("n", "<C-]>", ":vertical resize +2<CR>")

-- Naviagate buffers
setKeymap("n", "<S-l>", ":bnext<CR>")
setKeymap("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
setKeymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
setKeymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch between tab sizes 2 and 4
setKeymap("n", "<leader>t", function()
  if(vim.opt.shiftwidth:get() == 2) then
    vim.opt.shiftwidth = 4
    vim.opt.tabstop= 4
  else
    vim.opt.shiftwidth = 2
    vim.opt.tabstop= 2
  end
end)

-- Insert --
-- Press jk fast to enter
setKeymap("i", "jk", "<ESC>")

-- Visual --
-- Stay in indent mode
setKeymap("v", "<", "<gv")
setKeymap("v", ">", ">gv")

-- Move text up and down
setKeymap("v", "<A-j>", ":m .+1<CR>==")
setKeymap("v", "<A-k>", ":m .-2<CR>==")
setKeymap("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
setKeymap("x", "J", ":move '>+1<CR>gv-gv")
setKeymap("x", "K", ":move '<-2<CR>gv-gv")
setKeymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
setKeymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Custom --
-- Telescope --
setKeymap("", "<Leader>pp", ":lua require'telescope.builtin'.builtin{}<CR>")
-- most recently used files
setKeymap("", "<Leader>o", ":lua require'telescope.builtin'.oldfiles{}<CR>")
-- find buffer
setKeymap("", ";", ":lua require'telescope.builtin'.buffers{}<CR>")
-- find in current buffer
setKeymap("", "<Leader>/", ":lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>")
-- bookmarks
setKeymap("", "<Leader>'", ":lua require'telescope.builtin'.marks{}<CR>")
-- git files
setKeymap("", "<Leader>gi", ":lua require'telescope.builtin'.git_files{}<CR>")
-- all files
setKeymap("", "<Leader>sf", ":lua require'telescope.builtin'.find_files{}<CR>")
-- ripgrep like grep through dir
setKeymap("", "<Leader>rg", ":lua require'telescope.builtin'.live_grep{}<CR>")
-- ripgrep but with hidden files
setKeymap("", "<Leader>ga", ":lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u', '--hidden' } }<CR>")
-- pick color scheme
setKeymap("", "<Leader>cs", ":lua require'telescope.builtin'.colorscheme{}<CR>")
-- undo history
setKeymap("n", "<Leader>u", ":Telescope undo<CR>")
-- Harpoon keymaps
setKeymap("n", "<leader>mk", ":lua require'harpoon.mark'.add_file()<CR>")
--[[ setKeymap("n", "<leader>hr", ":lua require'harpoon.ui'.toggle_quick_menu()<CR>") ]]
setKeymap("n", "<leader>hr", ":Telescope harpoon marks<CR>")

-- NVIM Tree --
--[[ setKeymap("n", "<C-t>", ":NvimTreeToggle<CR>") ]]

-- UFO --
setKeymap("n", "zP", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

-- Debugging --
setKeymap("n", "<F5>", ":lua require'dap'.continue()<CR>")
setKeymap("n", "<F10>", ":lua require'dap'.step_over()<CR>")
setKeymap("n", "<F11>", ":lua require'dap'.step_into()<CR>")
setKeymap("n", "<F12>", ":lua require'dap'.step_out()<CR>")
setKeymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
setKeymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
setKeymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
setKeymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
setKeymap("n", "<leader>do", ":lua require'dapui'.toggle()<CR>")

-- Gitsigns --
setKeymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")

-- Terminal --
-- TODO: change exit insert mode keymap when in this window (also nice for terminal)
setKeymap("n", "<leader>lg", ":lua _LAZYGIT_TOGGLE()<CR>")
setKeymap("n", "<leader>gu", ":lua _GITUI_TOGGLE()<CR>")
-- setKeymap("n", "<leader>bc", ":lua _BACON_TOGGLE()<CR>")

-- Neovide keymaps
if vim.g.neovide then
  setKeymap("n", "+", ":lua ChangeScaleFactor(1.25)<CR>")
  setKeymap("n", "_", ":lua ChangeScaleFactor(1/1.25)<CR>")
end



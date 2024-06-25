-- CMP before lsp, because lsp config depends on cmp stuff
require('user.lazy.cmp')
require('user.lazy.lazy-lsp')
require('user.lazy.copilot')
require('user.lazy.neo-tree')
-- Telescope before dap, because dap config depends on telescope
require('user.lazy.telescope')
require('user.lazy.nvim-dap')

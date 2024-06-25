require('user.lazy.lualine')
require('user.lazy.neo-tree')
-- Harpoon before telescope, because telescope config depends on harpoon
require('user.lazy.harpoon')
-- Telescope before dap, because dap config depends on telescope
require('user.lazy.telescope')
-- CMP before lsp, because lsp config depends on cmp stuff
require('user.lazy.cmp')
require('user.lazy.lazy-lsp')
require('user.lazy.copilot')
require('user.lazy.nvim-dap')
require('user.lazy.toggleterm')
require('user.lazy.nvim-colorizer')
require('user.lazy.illuminate')
require('user.lazy.plugins')
require('user.lazy.ufo')
require('user.lazy.whitespace')
require('user.lazy.indent-blankline')
require('user.lazy.statuscol')
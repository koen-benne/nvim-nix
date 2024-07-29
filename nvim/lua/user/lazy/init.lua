-- Start Neotree only when it is used
vim.api.nvim_create_user_command('Neotree', function(opts)
  require('user.lazy.neo-tree')
  vim.cmd('Neotree ' .. opts.args)
end, { nargs = '*' })

-- For plugins that are only necessary once we are in a buffer
local buffer_plugins_loaded = false
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if not buffer_plugins_loaded then
      buffer_plugins_loaded = true

      vim.defer_fn(function()
        -- CMP before lsp, because lsp config depends on cmp stuff
        require('user.lazy.cmp')
        require('user.lazy.lazy-lsp')
        require('user.lazy.nvim-colorizer')
        require('user.lazy.illuminate')
        require('user.lazy.ufo')
        require('user.lazy.whitespace')
        require('user.lazy.indent-blankline')
        require('user.lazy.supermaven')
      end, 100)
    end
  end,
})

-- Other lazy plugins
vim.defer_fn(function()
  require('user.lazy.lualine')
  -- Harpoon before telescope, because telescope config depends on harpoon
  require('user.lazy.harpoon')
  -- Telescope before dap, because dap config depends on telescope
  require('user.lazy.telescope')
  require('user.lazy.toggleterm')
  require('user.lazy.plugins')
  require('user.lazy.statuscol')
  -- This one is slow and not usually important
  require('user.lazy.nvim-dap')
end, 100)

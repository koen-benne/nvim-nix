-- Start Neotree only when it is used
vim.api.nvim_create_user_command('Neotree', function(opts)
  require('user.lazy.neo-tree')
  vim.cmd('Neotree ' .. opts.args)
end, { nargs = '*' })

-- For plugins that are only necessary once we are in a buffer
local buffer_plugins_loaded = false

-- For plugins that are only necessary once we are in a buffer
local function load_buffer_plugins(args)
  local filetype = vim.bo[args.buf].filetype
  if filetype == 'alpha' or filetype == 'neo-tree' or filetype == 'TelescopePrompt' then
    return
  end

  if not buffer_plugins_loaded then
    buffer_plugins_loaded = true

    vim.defer_fn(function()
      require('user.lazy.blink')
      require('user.lazy.lazy-lsp')
      require('user.lazy.nvim-colorizer')
      require('user.lazy.illuminate')
      require('user.lazy.ufo')
      require('user.lazy.whitespace')
      require('user.lazy.indent-blankline')
      require('user.lazy.supermaven')

      -- Reload the buffer after the plugins are loaded. Especially important for lsp
      vim.api.nvim_exec([[ doautocmd BufReadPost ]], false)
    end, 100)
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = load_buffer_plugins,
})

-- Trigger the FileType autocommand explicitly for the first buffer
local initial_buf = vim.api.nvim_get_current_buf()
local initial_ft = vim.bo[initial_buf].filetype
if initial_ft ~= '' then
  load_buffer_plugins { buf = initial_buf }
end

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
end, 50)

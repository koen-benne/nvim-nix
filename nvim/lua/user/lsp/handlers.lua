local M = {}

M.setup = function()
  local icons = require('user.icons')
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>w', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- local notify_status_ok, notify = pcall(require, "notify")
-- if not notify_status_ok then
--   return
-- end

M.on_attach = function(client, bufnr)
  -- vim.notify(client.name .. " starting...")
  -- TODO: refactor this into a method that checks if string in list
  if client.name == 'tsserver' or client.name == 'html' or client.name == 'jdt.ls' then
    client.server_capabilities.document_formatting = false
  end

  if client.name == 'jdt.ls' then
    require('jdtls').setup_dap { hotcodereplace = 'auto' }
    require('jdtls.dap').setup_dap_main_class_configs()
    vim.lsp.codelens.refresh()
  end
  lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- This is for UFO
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local status_ok, blink = pcall(require, 'blink.cmp')
if not status_ok then
  vim.notify('Blink is not installed!')
  return
end

M.capabilities = blink.get_lsp_capabilities(capabilities)

function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.formatting()
    augroup end
  ]])
  vim.notify('Enabled format on save')
end

function M.disable_format_on_save()
  M.remove_augroup('format_on_save')
  vim.notify('Disabled format on save')
end

function M.toggle_format_on_save()
  if vim.fn.exists('#format_on_save#BufWritePre') == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists('#' .. name) == 1 then
    vim.cmd('au! ' .. name)
  end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.plugins.lsp.handlers").toggle_format_on_save()' ]])

return M

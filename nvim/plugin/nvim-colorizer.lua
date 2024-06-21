if vim.g.did_load_nvim_colorizer_plugin then
  return
end
vim.g.did_load_nvim_colorizer_plugin = true

local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup {
  filetypes = { 
    "*";
    conf = { RRGGBB = true; };
    css = { rgb_fn = true; };
    html = { names = false; };
    rasi = { RRGGBBAA = true; }
  },
}

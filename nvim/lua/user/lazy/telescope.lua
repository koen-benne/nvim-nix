if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

vim.cmd ( 'packadd! telescope.nvim' )
vim.cmd ( 'packadd! telescope-fzy-native.nvim' )
vim.cmd ( 'packadd! telescope-media-files.nvim' )
vim.cmd ( 'packadd! telescope-file-browser.nvim' )
vim.cmd ( 'packadd! telescope-undo.nvim' )

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
telescope.load_extension "media_files"
local icons = require("user.icons")

telescope.setup {
  defaults = {
    winblend = 10,

    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = icons.ui.Search .. " ",
    selection_caret = "  ",
    path_display = { "smart" },
    initial_mode = "insert",
    election_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    file_ignore_patterns = { "node_modules" },
    border = {},
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    color_devicons = true,
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ['<C-d>'] = actions.delete_buffer,

        -- ["<C-u>"] = actions.preview_scrolling_up,
        -- ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions_list = { "themes", "terms" },
  extensions = {
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf", "mkv" },
      find_cmd = "fd",
    },
    file_browser = {
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

-- TODO: check if these exist first
telescope.load_extension "file_browser"
telescope.load_extension "projects"
telescope.load_extension "harpoon"
telescope.load_extension "undo"


-- Telescope colors
local highlight = require("user.utils.highlights")

highlight.fg_bg("TelescopeBorder", "#16161d", "#16161d")
highlight.fg_bg("TelescopePromptBorder", "#1a1b26", "#1a1b26")

highlight.fg_bg("TelescopePromptNormal", "#fff", "#1a1b26")
highlight.fg_bg("TelescopePromptPrefix", "#957fb8", "#b1a1b26")

highlight.bg("TelescopeNormal", "#16161d")
highlight.bg("TelescopeMatching", "#b1a1b26")
highlight.bg("TelescopeSelectionCaret", "#957fb8")
highlight.bg("TelescopeSelection", "#b1a1b26")
highlight.bg("TelescopeMultiSelection", "#b1a1b26")

highlight.fg_bg("TelescopePreviewTitle", "#000000", "#7e9cd8")
highlight.fg_bg("TelescopePromptTitle", "#000000", "#957fb8")
highlight.fg_bg("TelescopeResultsTitle", "#16161d","#16161d")

highlight.bg("TelescopeSelection", "#3b323e")

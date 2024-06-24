# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # packadd! needs to be called for each of the optional plugins
    nvim-treesitter.withAllGrammars

    # LSP
    { plugin = lazy-lsp-nvim; optional = true; } # Uses nix for lsp stuff so that I don't have to install a bunch of stuff globally
    { plugin = nvim-lspconfig; optional = true; } # Auto config lsp
    { plugin = lspsaga-nvim; optional = true; }
    { plugin = SchemaStore-nvim; optional = true; }
    { plugin = copilot-lua; optional = true; }

    # Completion
    { plugin = nvim-cmp; optional = true; }
    { plugin = cmp_luasnip; optional = true; } # Snippets autocompletion extension for nvim-cmp
    { plugin = luasnip; optional = true; } # Snippets
    { plugin = cmp-nvim-lsp; optional = true; } # LSP as completion source
    { plugin = cmp-nvim-lsp-signature-help; optional = true; }
    { plugin = cmp-buffer; optional = true; } # Current buffer as completion source
    { plugin = cmp-path; optional = true; } # File paths as completion source
    { plugin = cmp-nvim-lua; optional = true; } # Neovim lua API as completion source
    { plugin = cmp-cmdline; optional = true; } # cmp command line suggestions
    { plugin = cmp-cmdline-history; optional = true; } # cmp command line history suggestions
    { plugin = crates-nvim; optional = true; }

    # Debugging
    { plugin = nvim-dap; optional = true; }
    { plugin = nvim-dap-go; optional = true; }
    { plugin = nvim-dap-ui; optional = true; }
    { plugin = nvim-dap-virtual-text; optional = true; }
    { plugin = telescope-dap-nvim; optional = true; }

    # Git integration
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/

    # telescope and extensions
    telescope-nvim
    telescope-fzy-native-nvim
    telescope-media-files-nvim
    telescope-file-browser-nvim
    telescope-undo-nvim

    # UI
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
    nvim-treesitter-context # nvim-treesitter-context
    kanagawa-nvim # Kanagawa theme
    alpha-nvim # Start screen
    neo-tree-nvim # File tree
    toggleterm-nvim # Terminal toggler
    vim-illuminate # Highlight all instances of a word under the cursor
    tagbar # Sidebar with tags
    rainbow-delimiters-nvim # Rainbow delimiters
    vim-ragtag # TODO: do i need this?
    vim-eunuch # TODO: do i need this?
    nvim-colorizer-lua

    # navigation/editing enhancement plugins
    vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
    nvim-surround # https://github.com/kylechui/nvim-surround/
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    leap-nvim # Jump to places
    nvim-autopairs # Automatically insert pairs
    nvim-ts-autotag # Automatically close typescript tags
    harpoon
    indent-blankline-nvim
    vim-surround
    whitespace-nvim
    comment-nvim
    nvim-ufo # Folding

    # Useful utilities
    nvim-unception # Prevent nested neovim sessions | nvim-unception
    vim-wakatime
    vim-startuptime
    persistence-nvim
    which-key-nvim
    editorconfig-nvim

    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    promise-async
    dressing-nvim
    nui-nvim

    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    (mkNvimPlugin inputs.project-nvim "project.nvim") # Project management
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    # lua-language-server
    # nil # nix LSP
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}

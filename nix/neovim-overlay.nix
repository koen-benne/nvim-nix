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
    # packadd needs to be called for each of the optional plugins
    nvim-treesitter.withAllGrammars

    # LSP
    { plugin = lazy-lsp-nvim; optional = true; } # Uses nix for lsp stuff so that I don't have to install a bunch of stuff globally
    { plugin = nvim-lspconfig; optional = true; } # Auto config lsp
    { plugin = lspsaga-nvim; optional = true; }
    { plugin = SchemaStore-nvim; optional = true; }
    { plugin = (mkNvimPlugin inputs.ts-error-translator-nvim "ts-error-translator.nvim"); optional = true; } # Error translator
    { plugin = (mkNvimPlugin inputs.supermaven-nvim "supermaven-nvim"); optional = true; } # Supermaven
    # { plugin = copilot-lua; optional = true; }

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
    gitsigns-nvim

    # telescope and extensions
    { plugin = telescope-nvim; optional = true; }
    { plugin = telescope-fzy-native-nvim; optional = true; }
    { plugin = telescope-media-files-nvim; optional = true; }
    { plugin = telescope-file-browser-nvim; optional = true; }
    { plugin = telescope-undo-nvim; optional = true; }

    # UI
    alpha-nvim # Start screen
    kanagawa-nvim # Kanagawa theme
    { plugin = neo-tree-nvim; optional = true; } # File tree
    { plugin = lualine-nvim; optional = true; } # Status line
    { plugin = toggleterm-nvim; optional = true; } # Terminal toggler
    { plugin = nvim-colorizer-lua; optional = true; }
    { plugin = statuscol-nvim; optional = true; } # Status column
    nvim-treesitter-context # nvim-treesitter-context
    { plugin = vim-illuminate; optional = true; } # Highlight all instances of a word under the cursor
    { plugin = rainbow-delimiters-nvim; optional = true; } # Rainbow delimiters

    # navigation/editing enhancement plugins
    { plugin = vim-unimpaired; optional = true; } # predefined ] and [ navigation keymaps
    { plugin = nvim-surround; optional = true; }
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-autopairs # Automatically insert pairs
    nvim-ts-autotag # Automatically close typescript tags
    { plugin = harpoon; optional = true; }
    { plugin = indent-blankline-nvim; optional = true; }
    { plugin = whitespace-nvim; optional = true; }
    comment-nvim
    { plugin = nvim-ufo; optional = true; } # Folding

    # Useful utilities
    { plugin = nvim-unception; optional = true; } # Prevent nested neovim sessions | nvim-unception
    persistence-nvim # For opening last session
    { plugin = which-key-nvim; optional = true; }
    { plugin = vim-wakatime; optional = true; }
    { plugin = editorconfig-nvim; optional = true; }
    vim-startuptime

    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    promise-async
    dressing-nvim
    nui-nvim

    (mkNvimPlugin inputs.project-nvim "project.nvim") # Project management
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    # lua-language-server
    # nil # nix LSP
    vscode-extensions.xdebug.php-debug
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
}

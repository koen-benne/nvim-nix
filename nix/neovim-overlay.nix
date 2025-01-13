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
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {inherit pkgs-wrapNeovim;};

  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # packadd needs to be called for each of the optional plugins (the default)

    zotcite

    # LSP
    lazy-lsp-nvim # Uses nix for lsp stuff so that I don't have to install a bunch of stuff globally
    nvim-lspconfig # Auto config lsp
    lspsaga-nvim
    SchemaStore-nvim

    (mkNvimPlugin inputs.ts-error-translator-nvim "ts-error-translator.nvim") # Error translator
    supermaven-nvim
    # { plugin = copilot-lua;  }

    # Completion
    luasnip # Snippets
    crates-nvim
    blink-cmp

    # Debugging
    nvim-dap
    nvim-dap-go
    nvim-dap-ui
    nvim-dap-virtual-text
    telescope-dap-nvim

    # Git integration
    {
      plugin = gitsigns-nvim;
      optional = false;
    }

    # telescope and extensions
    telescope-nvim
    telescope-fzy-native-nvim
    telescope-media-files-nvim
    telescope-file-browser-nvim
    telescope-undo-nvim

    # UI
    neo-tree-nvim # File tree
    lualine-nvim # Status line
    toggleterm-nvim # Terminal toggler
    nvim-colorizer-lua
    statuscol-nvim # Status column
    vim-illuminate # Highlight all instances of a word under the cursor
    rainbow-delimiters-nvim # Rainbow delimiters
    {
      plugin = alpha-nvim; # Start screen
      optional = false;
    }
    {
      plugin = kanagawa-nvim; # Kanagawa theme
      optional = false;
    }
    {
      plugin = nvim-treesitter-context; # nvim-treesitter-context
      optional = false;
    }

    # navigation/editing enhancement plugins
    vim-unimpaired # predefined ] and [ navigation keymaps
    nvim-surround
    harpoon
    indent-blankline-nvim
    whitespace-nvim
    nvim-ufo # Folding
    {
      plugin = nvim-treesitter.withAllGrammars;
      optional = false;
    }
    {
      plugin = nvim-treesitter-textobjects;
      optional = false;
    }
    {
      plugin = nvim-ts-context-commentstring;
      optional = false;
    }
    {
      plugin = nvim-autopairs; # Automatically insert pairs
      optional = false;
    }
    {
      plugin = nvim-ts-autotag; # Automatically close typescript tags
      optional = false;
    }
    {
      plugin = comment-nvim;
      optional = false;
    }

    # Useful utilities
    nvim-unception # Prevent nested neovim sessions | nvim-unception
    which-key-nvim
    vim-wakatime
    editorconfig-nvim
    {
      plugin = persistence-nvim; # For opening last session
      optional = false;
    }
    {
      plugin = vim-startuptime;
      optional = false;
    }

    # libraries that other plugins depend on
    {
      plugin = sqlite-lua;
      optional = false;
    }
    {
      plugin = plenary-nvim;
      optional = false;
    }
    {
      plugin = nvim-web-devicons;
      optional = false;
    }
    {
      plugin = promise-async;
      optional = false;
    }
    {
      plugin = dressing-nvim;
      optional = false;
    }
    {
      plugin = nui-nvim;
      optional = false;
    }

    {
      plugin = project-nvim; # Project management
      optional = false;
    }
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
}

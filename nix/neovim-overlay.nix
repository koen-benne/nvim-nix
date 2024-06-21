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

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    nvim-treesitter.withAllGrammars

    # LSP
    lazy-lsp-nvim # Uses nix for lsp stuff so that I don't have to install a bunch of stuff globally
    lspsaga-nvim
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    SchemaStore-nvim
    copilot-lua
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    cmp_luasnip # snippets autocompletion extension for nvim-cmp
    luasnip # snippets | https://github.com/l3mon4d3/luasnip/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions
    rust-tools-nvim
    crates-nvim

    # Debugging
    nvim-dap
    nvim-dap-go
    nvim-dap-ui
    nvim-dap-virtual-text
    telescope-dap-nvim

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
    lua-language-server
    nil # nix LSP
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

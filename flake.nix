{
  description = "tallenpeli.nvim - a batteries-included Neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      # Programs this config shells out to. Anything here is available on PATH
      # inside the wrapped Neovim and inside the dev shell.
      mkRuntimeDeps =
        pkgs:
        with pkgs;
        [
          # --- Language servers (see nvim/lua/tallenpeli/lsp.lua) ---
          nixd
          lua-language-server
          clang-tools # clangd
          pyright # pyright-langserver
          vscode-langservers-extracted # css/html/json/eslint language servers
          typescript-language-server
          rust-analyzer
          gopls
          zls
          qt6.qtdeclarative # qmlls

          # --- Formatters / linters (see nvim/lua/tallenpeli/plugins/formatter.lua) ---
          prettier
          stylua
          isort
          black
          pylint
          zig-zlint
          eslint_d
          rustfmt
          nixfmt

          # --- Treesitter parser builds ---
          tree-sitter
          gcc
          gnumake

          # --- Picker / git / preview / image support ---
          ripgrep
          fd
          git
          lazygit
          imagemagick
          xdg-utils
          curl

          # --- Toolchains referenced by the config / README ---
          rustc
          cargo
          go
        ]
        ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
          wl-clipboard
          xclip
        ];

      mkNeovim =
        pkgs:
        let
          lib = pkgs.lib;
          deps = mkRuntimeDeps pkgs;
          nvimConfig = ./nvim;
        in
        pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
          extraName = "-tallenpeli";

          # Load this repo's init.lua, then put the repo on the runtimepath so
          # require("tallenpeli...") resolves. Lazy.nvim still installs plugins
          # into the user's data directory on first launch.
          neovimRcContent = ''
            set runtimepath^=${nvimConfig}
            lua dofile("${nvimConfig}/init.lua")
          '';

          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (lib.makeBinPath deps)
          ];
        };

      mkDevShell =
        pkgs:
        pkgs.mkShell {
          packages = (mkRuntimeDeps pkgs) ++ (with pkgs; [ neovim ]);
          shellHook = ''
            echo "tallenpeli.nvim dev shell"
            echo "Start this config with:"
            echo "  nvim --cmd 'set runtimepath^=${./nvim}' -u ${./nvim}/init.lua"
          '';
        };

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          nvim = mkNeovim pkgs;
        in
        {
          default = nvim;
          tallenpeli-nvim = nvim;
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });

      devShells = forAllSystems (system: {
        default = mkDevShell (import nixpkgs { inherit system; });
      });

      formatter = forAllSystems (system: (import nixpkgs { inherit system; }).nixfmt);

      # Import this in home-manager:
      #
      #   inputs.tallenpeli-nvim.url = "github:TallenPeli/tallenpeli.nvim";
      #
      #   home-manager.users.me.imports = [
      #     inputs.tallenpeli-nvim.homeManagerModules.default
      #   ];
      #   programs.tallenpeli-nvim.enable = true;
      #
      # This installs Neovim with all runtime dependencies and links this
      # repository's nvim/ directory to ~/.config/nvim.
      homeManagerModules.default =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        let
          cfg = config.programs.tallenpeli-nvim;
        in
        {
          options.programs.tallenpeli-nvim.enable = lib.mkEnableOption "the tallenpeli.nvim Neovim configuration";

          config = lib.mkIf cfg.enable {
            programs.neovim = {
              enable = true;
              extraPackages = mkRuntimeDeps pkgs;
            };

            xdg.configFile."nvim".source = ./nvim;
          };
        };

      homeManagerModules.tallenpeli-nvim = self.homeManagerModules.default;
    };
}

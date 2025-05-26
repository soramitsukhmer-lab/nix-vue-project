{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                (self: super: {
                  yarn = super.yarn.override {
                    nodejs = super.nodejs_22;
                  };
                  # yarn-berry = super.yarn.override {
                  #   nodejs = super.nodejs_22;
                  # };
                  # pnpm = super.pnpm.override {
                  #   nodejs = super.nodejs_22;
                  # };

                  # Overlays for yarn hooks
                  fixup-yarn-lock = super.fixup-yarn-lock.overrideAttrs (oldAttrs: {
                    buildInputs = [
                      super.nodejs_22
                    ];
                  });
                  prefetch-yarn-deps = super.prefetch-yarn-deps.overrideAttrs (oldAttrs: {
                    buildInputs = [
                      super.nodejs_22
                    ];
                  });
                })
              ];
            };
          }
        );
    in
    {
      devShells = forEachSystem (
        { pkgs }:
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.nodejs_22
              pkgs.yarn
              # pkgs.yarn-berry
              # pkgs.pnpm
              # pkgs.pnpm_8
              # pkgs.pnpm_10

            ];
            shellHook = ''
              echo "Welcome to your Node.js development environment!"
              echo "Node.js $(node -v)"
            '';
          };
        }
      );
      packages = forEachSystem (
        { pkgs }: 
        {
          default = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "vue-project";
            version = "0.0.0";

            src = ./.;

            yarnOfflineCache = pkgs.fetchYarnDeps {
              yarnLock =  "${finalAttrs.src}/yarn.lock";
              hash = "sha256-qGJC7kEBaEaXdHD72h6/aOgU/VlSOL1uH39nJ+nNkOM=";
            };

            buildInputs = [
              pkgs.caddy
            ];

            nativeBuildInputs = [
              pkgs.yarn
              pkgs.yarnConfigHook
              pkgs.yarnBuildHook

              # pkgs.writableTmpDirAsHomeHook
              pkgs.nodejs_22
            ];

            buildPhase = ''
              mkdir -p $out
              ${pkgs.yarn}/bin/yarn build --outDir $out
            '';

            meta = { };
          });
        }
      );
    };
}

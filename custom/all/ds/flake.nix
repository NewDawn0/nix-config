{
  description = "A better pushd interface";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          overlays = [ inputs.rust-overlay.overlays.default ];
        };
    in {
      packages = eachSystem (system:
        let pkgs = mkPkgs system;
        in {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "dirStack";
            version = "0.0.1";
            propagatedBuildInputs = with pkgs; [ fzf ];
            cargoLock.lockFile = ./Cargo.lock;
            src = pkgs.lib.cleanSource ./.;
            meta = with pkgs.lib; {
              description = "A better pushd interface";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}

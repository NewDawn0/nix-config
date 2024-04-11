{
  description = "An extensible project generator";

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
        let
          pkgs = mkPkgs system;
          rustPlatform = pkgs.makeRustPlatform {
            cargo = pkgs.rust-bin.stable.latest.minimal;
            rustc = pkgs.rust-bin.stable.latest.minimal;
          };
        in {
          default = pkgs.rustPlatform.buildRustPackage {
            name = "gen";
            version = "0.0.1";
            cargoLock.lockFile = ./Cargo.lock;
            src = pkgs.lib.cleanSource ./.;
            meta = with pkgs.lib; {
              description = "An extensible project generator";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}

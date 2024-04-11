{
  description = "A commandline clock with nixie tubes";

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
            name = "nixie-clock";
            version = "0.0.1";
            cargoHash = "sha256-oqiXeX7ct2miDNoURF7+9lElebX4coVox+qzPgUBbj0=";
            src = builtins.fetchGit {
              url = "https://github.com/NewDawn0/nixie-clock";
              rev = "c8ebc0454a41a34a2bb5bcc66b37f44b022450b9";
            };
            meta = with pkgs.lib; {
              description = "A commandline clock with nixie tubes";
              homepage = "https://github.com/NewDawn0/nixie-clock";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}

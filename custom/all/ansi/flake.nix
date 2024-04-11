{
  description = "Ansi escape colors cheatsheet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.buildGoModule {
            name = "ansi";
            version = "0.1.0";
            src = ./.;
            vendorHash = null;
            meta = with pkgs.lib; {
              description = "Ansi escape colors cheatsheet";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}

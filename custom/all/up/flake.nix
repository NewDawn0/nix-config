{
  description = "Shell utility to cd faster";

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
          default = pkgs.stdenv.mkDerivation {
            name = "up";
            pname = "up-core";
            version = "0.1.0";
            src = ./.;
            buildInputs = with pkgs; [ gcc ];
            buildPhase = "gcc -o up-core ./up.c";
            installPhase = ''
              mkdir -p $out/bin
              mv up-core $out/bin
            '';
            meta = with pkgs.lib; {
              description =
                "A shell utiliity which eases the use of cd over multiple directories";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}

{
  description = "Useful mac apps";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs, }:
    let eachSystem = nixpkgs.lib.genAttrs [ "x86_64-darwin" "aarch64-darwin" ];
    in {
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.stdenv.mkDerivation {
            name = "Mac util apps";
            src = builtins.fetchGit {
              url = "https://github.com/NewDawn0/mac-apps-archive";
              rev = "456704456f39e471db5e9e38c23129bddbe73931";
            };
            installPhase = ''
              mkdir -p $out/Applications
              mv apps/* $out/Applications/
            '';
            meta = with pkgs.lib; {
              description = "Useful mac apps";
              platforms = platforms.darwin;
            };
          };
        });
    };
}

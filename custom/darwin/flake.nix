{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    homebrew-manager = {
      url = "path:./homebrew-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-util-apps = {
      url = "path:./mac-util-apps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs [ "x86_64-darwin" "aarch64-darwin" ];
    in {
      packages = eachSystem (system: {
        homebrew-manager = inputs.homebrew-manager.packages.${system}.default;
        mac-util-apps = inputs.mac-util-apps.packages.${system}.default;
      });
    };
}

{
  description = "NewDawn0's system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-systems.url = "github:nix-systems/default";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    ndnvim.url = "github:NewDawn0/ND-Nvim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-custom-pkgs = {
      url = "github:NewDawn0/nix-custom-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-darwin, ... }:
    let util = import ./lib { inherit inputs nixpkgs nixpkgs-unstable; };
    in {
      devShells = util.mkShells;
      nixosConfigurations = { };
      darwinConfigurations = {
        NewDawn0-mbpro2020 = nix-darwin.lib.darwinSystem {
          modules = [ ./hosts/NewDawn0-mbpro2020 ];
          specialArgs = {
            inherit self inputs;
            inherit (util.mkArgs "x86_64-darwin" "NewDawn0-mbpro2020" "tom")
              userInfo pkgs unstable overlays;
          };
        };
      };
    };
}

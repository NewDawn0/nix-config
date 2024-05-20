{
  description = "NewDawn0's system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-systems.url = "github:nix-systems/default";
    rust-overlay = { url = "github:oxalica/rust-overlay"; };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, ... }@inputs:
    let
      utils =
        import ./shared/flake { inherit inputs nixpkgs nixpkgs-unstable; };
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
      fn = import ./shared/flake/util-fns.nix { inherit (nixpkgs) lib; };
    in {
      devShells = eachSystem (system:
        let inherit (utils.mkPkgs system) pkgs unstable;
        in {
          macEnv = pkgs.callPackage ./devShells/macEnv.nix { inherit pkgs; };
          prefetchers =
            pkgs.callPackage ./devShells/prefetchers.nix { inherit pkgs; };
        });
      nixosConfigurations = { };
      darwinConfigurations = {
        NewDawn0 = nix-darwin.lib.darwinSystem {
          modules = [ ./hosts/mbpro-2020 ];
          specialArgs = {
            inherit self home-manager inputs fn;
            inherit (utils.mkInfo "x86_64-darwin" "tom" "NewDawn0")
              userInfo pkgs unstable;
          };
        };
      };
    };
}

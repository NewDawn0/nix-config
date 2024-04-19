{
  description = "NewDawn0's system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-systems.url = "github:nix-systems/default";
    base16.url = "github:SenchoPens/base16.nix";
    rust-overlay = { url = "github:oxalica/rust-overlay"; };
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    custom-linux = {
      url = "path:./custom/linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    custom-darwin = {
      url = "path:./custom/darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    custom-all = {
      url = "path:./custom/all";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, base16
    , ... }@inputs:
    let
      utils =
        import ./shared/flake { inherit inputs nixpkgs nixpkgs-unstable; };
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      devShells = eachSystem (system:
        let inherit (utils.mkPkgs system) pkgs unstable;
        in {
          macEnv = pkgs.callPackage ./devShells/macEnv.nix { inherit pkgs; };
        });
      nixosConfigurations = { };
      darwinConfigurations = {
        NewDawn0 = nix-darwin.lib.darwinSystem {
          modules = [ ./hosts/mbpro-2020 ];
          specialArgs = {
            inherit self home-manager base16 inputs;
            inherit (utils.mkInfo "x86_64-darwin" "tom" "NewDawn0")
              userInfo pkgs unstable;
          };
        };
      };
    };
}

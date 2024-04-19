{
  description = "Custom packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
    rust-overlay.url = "github:oxalica/rust-overlay";
    dirStack = {
      url = "github:NewDawn0/dirStack";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    gen = {
      url = "github:NewDawn0/gen";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    nixie-clock = {
      url = "github:NewDawn0/nixie-clock";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    note = {
      url = "github:NewDawn0/note";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
    rgpt = {
      url = "github:NewDawn0/rgpt";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    shell-utils = {
      url = "github:NewDawn0/shell-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
    tl = {
      url = "github:NewDawn0/tl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      packages = eachSystem (system: {
        ansi = inputs.shell-utils.packages.${system}.ansi;
        dirStack = inputs.dirStack.packages.${system}.default;
        ex = inputs.shell-utils.packages.${system}.ex;
        gen = inputs.gen.packages.${system}.default;
        nixie-clock = inputs.nixie-clock.packages.${system}.default;
        note = inputs.note.packages.${system}.default;
        rgpt = inputs.rgpt.packages.${system}.default;
        translate = inputs.translate.packages.${system}.default;
        up = inputs.shell-utils.packages.${system}.up;
      });
    };
}

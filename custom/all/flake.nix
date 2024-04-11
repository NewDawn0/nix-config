{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
    rust-overlay.url = "github:oxalica/rust-overlay";
    ansi = {
      url = "path:./ansi";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
    ds = {
      url = "path:./ds";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    ex = {
      url = "path:./ex";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
    gen = {
      url = "path:./gen";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    nixie-clock = {
      url = "path:./nixie-clock";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    note = {
      url = "path:./note";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
    rgpt = {
      url = "path:./rgpt";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    translate = {
      url = "path:./translate";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    up = {
      url = "path:./up";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-systems.follows = "nix-systems";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      packages = eachSystem (system: {
        ansi = inputs.ansi.packages.${system}.default;
        ds = inputs.ds.packages.${system}.default;
        ex = inputs.ex.packages.${system}.default;
        gen = inputs.gen.packages.${system}.default;
        nixie-clock = inputs.nixie-clock.packages.${system}.default;
        note = inputs.note.packages.${system}.default;
        rgpt = inputs.rgpt.packages.${system}.default;
        translate = inputs.translate.packages.${system}.default;
        up = inputs.up.packages.${system}.default;
      });
    };
}

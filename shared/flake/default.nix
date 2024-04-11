{ inputs, nixpkgs, nixpkgs-unstable, }:
let
  config = { allowUnfree = true; };
  overlays = import ./overlays.nix { inherit inputs; };
  mkAllPkgs = system: {
    pkgs = import nixpkgs { inherit config system overlays; };
    unstable = import nixpkgs-unstable { inherit config system overlays; };
  };
in {
  mkPkgs = system: mkAllPkgs system;
  mkInfo = system: userName: hostName:
    let inherit (mkAllPkgs system) pkgs unstable;
    in {
      inherit pkgs unstable;
      userInfo = {
        inherit userName hostName system;
        userHome = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
          + userName;
      };
    };
}

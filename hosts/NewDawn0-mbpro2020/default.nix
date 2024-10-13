{ config, inputs, lib, overlays, pkgs, self, unstable, userInfo, util, ... }:
let
  importPath = import ../../lib/importPath.nix {
    inherit config inputs lib overlays pkgs self unstable userInfo util;
  };
in {
  imports = importPath ../../shared/system ++ [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.stylix.darwinModules.stylix
  ];
  users.users.${userInfo.userName}.home = userInfo.userHome;
  home-manager = {
    extraSpecialArgs = { inherit inputs overlays pkgs unstable userInfo util; };
    users.${userInfo.userName} = import ./home.nix;
  };
}

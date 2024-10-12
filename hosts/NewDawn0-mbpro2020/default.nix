{ config, home-manager, inputs, lib, overlays, pkgs, self, unstable, userInfo
, util, ... }:
let
  importPath = import ../../lib/importPath.nix {
    inherit config home-manager inputs lib overlays pkgs self unstable userInfo
      util;
  };
in {
  imports = importPath ../../shared/system ++ [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.stylix.darwinModules.stylix
  ];
  environment.systemPackages = with pkgs; [
    coreutils
    less
    ndnvim
    blockbench
    prismlauncher
  ];
}

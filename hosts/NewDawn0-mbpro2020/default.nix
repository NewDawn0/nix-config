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
  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs unstable userInfo fn; };
    users.${userInfo.userName} = import ./home.nix;
  };
  environment.systemPackages = with pkgs; [
    coreutils
    less
    ndnvim
    blockbench
    prismlauncher
  ];
}
